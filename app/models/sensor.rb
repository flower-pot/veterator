class Sensor < ActiveRecord::Base
  belongs_to :unit
  has_one :type, through: :unit
	alias :unit_type :type
  has_many :records, dependent: :destroy
  belongs_to :user

  validates :name,
    presence: true

  validates :unit_id,
    presence: true

  validates :user_id,
    presence: true

  def statistics(since = 1.day.ago)
    arecords = records.where('created_at > ?', since).order('value ASC')
    statistics_data = Hash.new
    statistics_data[:min] = 0
    statistics_data[:max] = 0
    statistics_data[:avg] = 0
    statistics_data[:q1] = 0
    statistics_data[:q2] = 0
    statistics_data[:q3] = 0
    statistics_data[:iqr] = 0
    if arecords.count > 0
      statistics_data[:min] = arecords.minimum('value')
      statistics_data[:max] = arecords.maximum('value')
      statistics_data[:avg] = arecords.average('value')
      # calcultates the first through third quartile and the interquartile range
      statistics_data[:q1] = arecords[(arecords.count/4).to_i].value
      statistics_data[:q2] = arecords[(arecords.count/2).to_i].value
      statistics_data[:q3] = arecords[((arecords.count/4)*3).to_i].value
      statistics_data[:iqr] = statistics_data[:q3] - statistics_data[:q1]
    end
    statistics_data
  end
end
