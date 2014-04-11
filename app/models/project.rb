# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Project < ActiveRecord::Base
  validates_presence_of :name, :description
  validates_uniqueness_of :name, message: "Title must be unique."
  validates_length_of :name, minimum: 5
  validates_length_of :description, minimum: 10

  has_many :issues

  after_create :add_to_timeline,

  private

  def add_to_timeline
    Timeline.create!({content: "An #{self.class.to_s} was created!", timelineable_id: id, timelineable_type: self.class.to_s})
  end
end
