class SensorAccess < ActiveRecord::Base
  belongs_to :sensor
  belongs_to :user

  enum access_level: [:read_write, :read_only]
end
