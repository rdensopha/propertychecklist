require 'spec_helper'

describe "download_links/index" do
  before(:each) do
    assign(:download_links, [
      stub_model(DownloadLink,
        :name => "Name",
        :status => "Status",
        :url => "MyText"
      ),
      stub_model(DownloadLink,
        :name => "Name",
        :status => "Status",
        :url => "MyText"
      )
    ])
  end

  it "renders a list of download_links" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
