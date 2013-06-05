require 'spec_helper'

describe "download_links/show" do
  before(:each) do
    @download_link = assign(:download_link, stub_model(DownloadLink,
      :name => "Name",
      :status => "Status",
      :url => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Status/)
    rendered.should match(/MyText/)
  end
end
