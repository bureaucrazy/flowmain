class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :status, :error, :ts_Data, :sensor_id
end
