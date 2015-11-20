class Sensor < ActiveRecord::Base
  belongs_to :site

  has_many :scadas, dependent: :nullify
  has_many :notifications, dependent: :nullify

end
