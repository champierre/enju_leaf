class Shelf < ActiveRecord::Base
  default_scope :order => "position"
  scope :real, :conditions => ['library_id != 1']
  belongs_to :library, :validate => true
  has_many :items, :include => [:use_restrictions, :circulation_status]
  has_many :picture_files, :as => :picture_attachable, :dependent => :destroy
  #has_many :shelf_has_manifestations, :dependent => :destroy
  #has_many :manifestations, :through => :shelf_has_manifestations
  #has_one :user_has_shelf, :dependent => :destroy
  #has_one :user, :through => :user_has_shelf

  validates_associated :library
  validates_presence_of :name, :display_name, :library
  validates_uniqueness_of :name, :case_sensitive => false
  validates_uniqueness_of :display_name
  before_validation :set_display_name, :on => :create
  
  acts_as_list :scope => :library
  #acts_as_soft_deletable

  def self.per_page
    10
  end

  def set_display_name
    self.display_name = self.name if display_name.blank?
  end

  def web_shelf?
    return true if self.id == 1
    false
  end

  def self.web
    Shelf.find(1)
  end

  def first?
    # 必ずposition順に並んでいる
    return true if library.shelves.first.position == position
    false
  end

  def localized_display_name
    display_name.localize
  end

end