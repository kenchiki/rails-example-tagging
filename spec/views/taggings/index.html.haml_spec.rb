require 'rails_helper'

RSpec.describe "taggings/index", type: :view do
  before(:each) do
    assign(:taggings, [
      Tagging.create!(
        :article => nil,
        :tag => nil
      ),
      Tagging.create!(
        :article => nil,
        :tag => nil
      )
    ])
  end

  it "renders a list of taggings" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
