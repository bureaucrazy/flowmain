module Api
  module V1
    class NotificationsController < ApplicationController
      respond_to :json

      def index
        respond_with Notification.all.order(:ts_data).reverse_order
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

      def all_sensor_status
        ary_status = Notification.order(:ts_data).reverse_order.limit(Notification.pluck(:sensor_id).uniq.count).pluck(:status)
        status = Hash.new(0)
        status = {1 => 0, 2 => 0, 3 => 0, 4 => 0}
        ary_status.each {|x| status[x] += 1}
        output = []
        output[0] = {id: 1, name: :OK, value: status[1]}
        output[1] = {id: 2, name: :WARNING, value: status[2]}
        output[2] = {id: 3, name: :DANGER, value: status[3]}
        output[3] = {id: 4, name: :ACK, value: status[4]}
        respond_with {|format| format.json  { render :json => {:status => output}}}

      end

    end
  end
end
