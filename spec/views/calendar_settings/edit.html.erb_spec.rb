require 'spec_helper'

describe "calendar_settings/edit" do
  before(:each) do
    @calendar_setting = assign(:calendar_setting, stub_model(CalendarSetting,
      :doctor_id => 1,
      :slotMinutes => 1,
      :minTime => 1,
      :maxTime => 1,
      :firstHour => 1,
      :defaultEventMinutes => 1
    ))
  end

  it "renders the edit calendar_setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => calendar_settings_path(@calendar_setting), :method => "post" do
      assert_select "input#calendar_setting_doctor_id", :name => "calendar_setting[doctor_id]"
      assert_select "input#calendar_setting_slotMinutes", :name => "calendar_setting[slotMinutes]"
      assert_select "input#calendar_setting_minTime", :name => "calendar_setting[minTime]"
      assert_select "input#calendar_setting_maxTime", :name => "calendar_setting[maxTime]"
      assert_select "input#calendar_setting_firstHour", :name => "calendar_setting[firstHour]"
      assert_select "input#calendar_setting_defaultEventMinutes", :name => "calendar_setting[defaultEventMinutes]"
    end
  end
end
