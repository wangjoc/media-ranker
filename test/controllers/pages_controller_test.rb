require "test_helper"

describe PagesController do
  it "must get home if logged in" do
    perform_login

    get pages_home_url
    must_respond_with :success
  end

  it "must redirect to login page if not logged in" do
    get pages_home_url
    must_respond_with :redirect
  end
end

