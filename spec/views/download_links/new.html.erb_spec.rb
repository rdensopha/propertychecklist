require 'spec_helper'

describe "download_links/new" do
  before(:each) do
    assign(:download_link, stub_model(DownloadLink,
      :name => "MyString",
      :status => "MyString",
      :url => "MyText"
    ).as_new_record)
  end

  it "renders new download_link form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", download_links_path, "post" do
      assert_select "input#download_link_name[name=?]", "download_link[name]"
      assert_select "input#download_link_status[name=?]", "download_link[status]"
      assert_select "textarea#download_link_url[name=?]", "download_link[url]"
    end
  end
end
