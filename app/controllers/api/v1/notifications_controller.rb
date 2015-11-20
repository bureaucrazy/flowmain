module Api
  module V1
    class NotificationsController < ApplicationController
      respond_to :json

      def index
        respond_with Notification.all
      end

      def show
        respond_with Notification.find(params[:id])
      end

      def sensor_notification
        respond_with Notification.where("sensor_id = ?", params[:id])
      end

      def sensor_status
        respond_with Notification.where("sensor_id = ?", params[:id]).last
      end

    end
  end
end
