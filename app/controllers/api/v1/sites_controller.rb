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

   end
 end
end
