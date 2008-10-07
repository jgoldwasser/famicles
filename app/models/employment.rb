class Employment < ActiveRecord::Base
  validates_presence_of :profile_id
  validates_presence_of :employer_id

  belongs_to :profile
  belongs_to :employer
end
