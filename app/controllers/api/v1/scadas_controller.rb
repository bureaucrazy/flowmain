module Api
 module V1
   class ScadasController < ApplicationController
     respond_to :json

     def index
       respond_with Scada.all
     end

     def show
       respond_with Scada.find(params[:id])
     end

   end
 end
end
