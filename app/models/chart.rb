class Chart < ApplicationRecord
  # validates :type, presence: true
  # validates :title, presence: true
  # validates :url, presence: true
  
  has_many :series
  has_one :x_axis
end
