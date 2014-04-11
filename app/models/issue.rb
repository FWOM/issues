# == Schema Information
#
# Table name: issues
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  description  :text
#  no_followers :integer
#  created_at   :datetime
#  updated_at   :datetime
#  project_id   :integer          default(1)
#  tags         :string(255)
#

class Issue < ActiveRecord::Base
  validates_presence_of :title, :description, :no_followers
  validates_uniqueness_of :title, message: "Title must be unique."
  validates_length_of :title, minimum: 5
  validates_length_of :description, minimum: 10
  validates_numericality_of :no_followers, message: "No followers must be a number"
  validates_with Yesnovalidator

  belongs_to :project

  before_save :strip_spaces_from_tags
  after_create :add_to_timeline

  private
  def strip_spaces_from_tags
    self.tags.gsub!(', ', ',')
  end

  def add_to_timeline
    Timeline.create!({content: "An #{self.class.to_s} was created!", timelineable_id: id, timelineable_type: self.class.to_s})
  end

end
