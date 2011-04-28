class CirculationStatus < ActiveRecord::Base
  include MasterModel
  scope :available_for_checkout, where(:name => 'Available On Shelf')
  has_many :items
end
