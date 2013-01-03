require 'spec_helper'

describe "calendar_settings/index" do
  before(:each) do
    assign(:calendar_settings, [
      stub_model(CalendarSetting,
        :doctor_id => 1,
        :slotMinutes => 2,
        :minTime => 3,
        :maxTime => 4,
        :firstHour => 5,
        :defaultEventMinutes => 6
      ),
      stub_model(CalendarSetting,
        :doctor_id => 1,
        :slotMinutes => 2,
        :minTime => 3,
        :maxTime => 4,
        :firstHour => 5,
        :defaultEventMinutes => 6
      )
    ])
  end

  it "renders a list of calendar_settings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
  end
end
