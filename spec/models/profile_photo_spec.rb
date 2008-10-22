require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

TEST_DIR = "tmp/test_images"

describe ProfilePhoto do
  before(:all) do
    ProfilePhoto.attachment_options[:path_prefix] =
        "#{TEST_DIR}/images"
  end

  after(:all) do
    FileUtils.rm_rf File.join(RAILS_ROOT, TEST_DIR)
  end

  it "should create a new instance given valid attributes" do
    @image = ProfilePhoto.new
    @image.profile_id = 1
    @image.uploaded_data = fixture_file_upload("images/profile.jpg", "image/jpg")
    @image.save

    #@image = ProfilePhoto.create(:profile_id => 1, :uploaded_data => fixture_file_upload("images/profile.jpg", "image/jpg"))
  end
end
# == Schema Info
# Schema version: 20081011041853
#
# Table name: profile_photos
#
#  id           :integer(4)      not null, primary key
#  parent_id    :integer(4)
#  profile_id   :integer(4)      not null
#  content_type :string(255)     not null, default("")
#  filename     :string(255)     not null, default("")
#  height       :integer(4)
#  size         :integer(4)      not null
#  thumbnail    :string(255)
#  width        :integer(4)
#  created_at   :datetime
#  updated_at   :datetime

