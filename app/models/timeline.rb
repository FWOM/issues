# == Schema Information
#
# Table name: timelines
#
#  id                :integer          not null, primary key
#  content           :string(255)
#  timelineable_type :string(255)
#  timelineable_id   :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Timeline < ActiveRecord::Base
  belongs_to :timelineable, polymorphic: true
end
