require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include FamicleTestHelper

describe Photo do
  before(:all) do
    #Photo.attachment_options[:path_prefix] =
    #    "#{TEST_DIR}/images"
  end

  after(:all) do
    #FileUtils.rm_rf File.join(RAILS_ROOT, TEST_DIR)
  end

  it "should create a new instance given valid attributes" do
    @image = Photo.new
    @image.image = fixture_file_upload("images/profile.jpg", "image/jpg")
    @image.save
  end
end
# == Schema Info
# Schema version: 20081105063617
#
# Table name: photos
#
#  id                 :integer(4)      not null, primary key
#  attachable_id      :integer(4)
#  attachable_type    :string(255)
#  image_content_type :string(255)
#  image_file_name    :string(255)
#  image_file_size    :string(255)
#  created_at         :datetime
#  image_updated_at   :string(255)
#  updated_at         :datetime

