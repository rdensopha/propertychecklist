require 'spec_helper'

describe "download_links/edit" do
  before(:each) do
    @download_link = assign(:download_link, stub_model(DownloadLink,
      :name => "MyString",
      :status => "MyString",
      :url => "MyText"
    ))
  end

  it "renders the edit download_link form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", download_link_path(@download_link), "post" do
      assert_select "input#download_link_name[name=?]", "download_link[name]"
      assert_select "input#download_link_status[name=?]", "download_link[status]"
      assert_select "textarea#download_link_url[name=?]", "download_link[url]"
    end
  end
end
