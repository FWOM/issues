# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  belongs_to :user

  validates :content, :length => {:maximum => 140, :minimum => 3}
  validates_presence_of :content, :user_id

  default_scope :order => 'microposts.created_at DESC'

  after_create 'add_to_timeline'

  private
  def add_to_timeline
    Timeline.create!({content: "An #{self.class.to_s} was created!", timelineable_id: id, timelineable_type: self.class.to_s})
  end
end
