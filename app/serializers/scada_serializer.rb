class ScadaSerializer < ActiveModel::Serializer
  attributes :id, :value, :ts_data, :sensor_id
end
