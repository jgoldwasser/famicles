class Employment < ActiveRecord::Base
  validates_presence_of :profile
  validates_presence_of :employer
  attr_accessor :employer_name

  belongs_to :profile
  belongs_to :employer

  def employer_name=(name)
    self.employer = Employer.find_or_initialize_by_name(name)
  end

  def employer_name
    self.employer.nil? ? "" : self.employer.name
  end
end
# == Schema Info
# Schema version: 20081105063617
#
# Table name: employments
#
#  id          :integer(4)      not null, primary key
#  employer_id :integer(4)      not null
#  profile_id  :integer(4)      not null
#  description :string(500)
#  end         :string(20)
#  location    :string(50)
#  position    :string(100)
#  start       :string(20)
#  created_at  :datetime
#  updated_at  :datetime

