class SubjectHeadingType < ActiveRecord::Base
  #has_many_polymorphs :subjects, :from => [:concepts, :places], :through => :subject_heading_type_has_subjects
  has_many :subject_heading_type_has_subjects
  has_many :subjects, :through => :subject_heading_type_has_subjects

  validates_presence_of :name, :display_name
  validates_uniqueness_of :name
  before_validation :set_display_name, :on => :create

  acts_as_list

  def set_display_name
    self.display_name = self.name if display_name.blank?
  end

end