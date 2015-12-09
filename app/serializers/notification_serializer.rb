class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :status, :error, :ts_data, :sensor_id
end
