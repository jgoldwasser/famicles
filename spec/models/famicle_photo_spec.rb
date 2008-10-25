require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include FamicleTestHelper

describe FamiclePhoto do
  before(:all) do
    FamiclePhoto.attachment_options[:path_prefix] =
        "#{TEST_DIR}/images"
  end

  after(:all) do
    FileUtils.rm_rf File.join(RAILS_ROOT, TEST_DIR)
  end

  it "should create a new instance given valid attributes" do
    @image = FamiclePhoto.new
    @image.famicle_id = 1
    @image.uploaded_data = fixture_file_upload("images/profile.jpg", "image/jpg")
    @image.save
  end
end
