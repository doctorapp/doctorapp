require 'spec_helper'

describe "calendar_settings/show" do
  before(:each) do
    @calendar_setting = assign(:calendar_setting, stub_model(CalendarSetting,
      :doctor_id => 1,
      :slotMinutes => 2,
      :minTime => 3,
      :maxTime => 4,
      :firstHour => 5,
      :defaultEventMinutes => 6
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
  end
end
