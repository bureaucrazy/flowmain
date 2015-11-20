class SensorSerializer < ActiveModel::Serializer
  attributes :id, :name, :sensor_type, :current_sensor_status, :description, :warning_threshold, :danger_threshold, :site_id

  has_many :scadas
  has_many :notifications

  def current_sensor_status
    Notification.where("sensor_id = ?", id).pluck(:status).last
  end
end
