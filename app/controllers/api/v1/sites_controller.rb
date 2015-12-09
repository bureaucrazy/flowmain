module Api
  module V1
    class SitesController < ApplicationController
      respond_to :json

      def index
        respond_with Site.all
      end

      def show
        respond_with Site.find_by_id(params[:id])
      end

      def get_list_per_site
        if params[:id]
          @site = Site.where("id = ?", params[:id])
          @sensor = Sensor.where("site_id = ?", params[:id])

          respond_with do |format|
            format.json  { render :json => {:site   => @site,
                                            :sensor => @sensor }}
          end
        end
      end

      def get_sensor_names_and_scada_values_per_site
        output = {}
        Sensor.where('site_id = ?', params[:id]).each { |sensor|
          values = []
          Scada.where('sensor_id = ? AND ts_data > ?', sensor.id, Time.now - 1.day).order(:ts_data).each { |scada|
            values << scada.value
          }
          output[:name] = "{sensor.id} - {sensor.name}"
          output[:data] = values
        }
        respond_with do |format|
          format.json { render :json => output }
        end
      end

      def get_all_sensor_names_and_scada_values
        output = []
        Site.all.each { |site|
          sites = {}
          sensor_scada = {}
          Sensor.where('site_id = ?', site.id).each { |sensor|
            values = []
            Scada.where('sensor_id = ? AND ts_data > ?', sensor.id, Time.now - 1.day).order(:ts_data).each { |scada|
              values << scada.value
            }
            sensor_scada[:name] = "#{sensor.id}-#{sensor.name}"
            sensor_scada[:description] = sensor.description
            sensor_scada[:warning] = sensor.warning_threshold
            sensor_scada[:danger] = sensor.danger_threshold
            sensor_scada[:data] = values
          }
          sites[:id] = site.id
          sites[:name] = site.name
          sites[:details] = sensor_scada

          output << sites
        }
        respond_with do |format|
          format.json { render :json => output }
        end
      end
    end
  end
end
