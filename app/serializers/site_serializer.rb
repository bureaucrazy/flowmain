class SiteSerializer < ActiveModel::Serializer
  attributes :id, :name, :current_site_status, :long, :lat, :description, :url

  has_many :sensors
  # has_many :scadas, through: :sensors
  # has_many :notifications, through: :sensors

  def current_site_status
    ary_sensors = []
    ary_status = []
    ary_sensors = Sensor.where("site_id = ?", id).pluck(:id)
    ary_sensors.each do |sensor_id|
      ary_status << Notification.where("sensor_id = ?", sensor_id).pluck(:status).last
    end
    ary_status.max
  end

  def url
    api_v1_site_path(object)
  end
end
