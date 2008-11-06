require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper
include FamicleTestHelper

describe PregnancyStat do
  before(:each) do
    setup_user_with_profile
    create_prearrival
    @valid_attributes = {
      :prearrival => @prearrival,
      :date => Date.today,
      :week => "1",
      :weight => "99.99",
      :weight_gain => "1.5",
      :blood_pressure => "1",
      :stomach_measurement => "9.99",
      :baby_heartrate => "1",
    }
  end

  it "should create a new instance given valid attributes" do
    PregnancyStat.create!(@valid_attributes)
  end

  it "should not create a new instance with invalid attributes" do
    PregnancyStat.create(@valid_attributes.except(:prearrival)).save.should eql(false)
    PregnancyStat.create(@valid_attributes.except(:date)).save.should eql(false)
  end


  describe 'adding new stats' do
    it 'should increase the number of stats on addition' do
      lambda do
        @prearrival.pregnancy_stats.create(@valid_attributes).should
      end.should change(@prearrival.pregnancy_stats, :count).by(1)
    end
  end

  describe 'removing stats' do
    it 'descrease total number of stats when one is removed' do
      @prearrival.pregnancy_stats.create(@valid_attributes)
      lambda do
        @prearrival.pregnancy_stats.first.destroy
      end.should change(@prearrival.pregnancy_stats, :count).by(-1)
    end
  end

private
  def stat_params

  end

end



# == Schema Info
# Schema version: 20081105063617
#
# Table name: pregnancy_stats
#
#  id                  :integer(4)      not null, primary key
#  prearrival_id       :integer(4)      not null
#  baby_heartrate      :integer(4)
#  blood_pressure      :integer(4)
#  date                :date            not null
#  stomach_measurement :integer(10)
#  week                :integer(4)
#  weight              :integer(10)
#  weight_gain         :integer(10)
#  created_at          :datetime
#  updated_at          :datetime

