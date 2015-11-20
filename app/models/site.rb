class Site < ActiveRecord::Base
  has_many :sensors, dependent: :nullify
  has_many :scadas, through: :sensors
  has_many :notifications, through: :sensors
end
