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

     def get_list_per_site
       if params[:id]
        @site = Site.find params[:id]
        @sensor = Sensor.where("site_id = ?", params[:id])

        respond_with do |format|
          format.json  { render :json => {:site => @site,
                                          :sensor => @sensor }}
        end
      end
    end

   end
 end
end
