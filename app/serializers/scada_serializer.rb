class ScadaSerializer < ActiveModel::Serializer
  attributes :id, :value, :ts_Data, :sensor_id
end
