module Api
 module V1
   class SensorsController < ApplicationController
     respond_to :json

     def index
       respond_with Sensor.all
     end

     def show
       respond_with Sensor.find(params[:sensor_id])
     end

     def get_list_per_site
       if params[:site_id]
        # respond_with Sensor.where(site_id: params[:site_id]).all
        # respond_with Sensor.where("site_id = ?", params[:site_id])

        @site = Site.find params[:site_id]
        @sensor = Sensor.where("site_id = ?", params[:site_id])

        respond_with do |format|
          format.json  { render :json => {:site => @site,
                                          :sensor => @sensor }}
        end
      end
    end

   end
 end
end
