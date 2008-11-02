require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include FamicleTestHelper

describe Photo do
  before(:all) do
    Photo.attachment_options[:path_prefix] =
        "#{TEST_DIR}/images"
  end

  after(:all) do
    FileUtils.rm_rf File.join(RAILS_ROOT, TEST_DIR)
  end

  it "should create a new instance given valid attributes" do
    @image = Photo.new
    @image.uploaded_data = fixture_file_upload("images/profile.jpg", "image/jpg")
    @image.save
  end
end
# == Schema Info
# Schema version: 20081031044850
#
# Table name: photos
#
#  id              :integer(4)      not null, primary key
#  attachable_id   :integer(4)
#  parent_id       :integer(4)
#  attachable_type :string(255)
#  content_type    :string(255)     not null, default("")
#  filename        :string(255)     not null, default("")
#  height          :integer(4)
#  size            :integer(4)      not null
#  thumbnail       :string(255)
#  width           :integer(4)
#  created_at      :datetime
#  updated_at      :datetime

