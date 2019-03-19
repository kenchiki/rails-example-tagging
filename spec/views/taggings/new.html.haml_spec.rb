require 'rails_helper'

RSpec.describe "taggings/new", type: :view do
  before(:each) do
    assign(:tagging, Tagging.new(
      :article => nil,
      :tag => nil
    ))
  end

  it "renders new tagging form" do
    render

    assert_select "form[action=?][method=?]", taggings_path, "post" do

      assert_select "input[name=?]", "tagging[article_id]"

      assert_select "input[name=?]", "tagging[tag_id]"
    end
  end
end
