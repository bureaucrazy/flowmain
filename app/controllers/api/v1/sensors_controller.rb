module Api
  module V1
    class SensorsController < ApplicationController
      respond_to :json

      def index
        respond_with Sensor.all
      end

      def show
        respond_with Sensor.find(params[:id])
      end

      def get_list_per_sensor
        if params[:id]
          @sensors = Sensor.where("id = ?", params[:id]).pluck(:name)
          @scadas = Scada.where("sensor_id = ? and ts_data > ?", params[:id], Time.now - 1.day).order(:ts_data).pluck(:value)

          respond_with do |format|
            format.json  { render :json => {:name => @sensors,
                                            :data => @scadas }}
          end
        end
      end
    end
  end
end
