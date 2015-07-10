require 'spec_helper'

RSpec.describe "homepage", type: :feature do
  it "loads the homepage" do
    get "/"
    expect(last_response.body).to include("Open HQ")
  end
end
