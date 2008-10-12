require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProfilePhoto do
  it "should create a new instance given valid attributes" do
    @image = ProfilePhoto.new
    @image.profile_id = 1
    @image.uploaded_data = fixture_file_upload("images/profile.jpg", "image/jpg")
    @image.save

    #@image = ProfilePhoto.create(:profile_id => 1, :uploaded_data => fixture_file_upload("images/profile.jpg", "image/jpg"))
  end
end
