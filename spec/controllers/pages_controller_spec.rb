require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do 
    @base_title = "Ruby on Rails Tutorial Sample App | "
  end

  describe "GET 'home'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
        :content => @base_title+"Home")
    end
    
    describe "Micropost counter sidebar" do
      
      it "should display singlular micropost" do
        micropost = Factory(:micropost, :user => @user)
        get 'home'
        response.should have_selector("span", :content => "1 micropost")
      end

      it "should display plural microposts" do
        micropost = Factory(:micropost, :user => @user)
        micropost2 = Factory(:micropost, :user => @user)
        get 'home'
        response.should have_selector("span", :content => "2 microposts")
      end
    end

    describe "Feed" do
      
      before(:each) do
        50.times do
          Factory(:micropost, :user => @user)
        end
      end

      it "should paginate microposts" do
        get 'home'
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/?page=2",
                                           :content => "2")
        response.should have_selector("a", :href => "/?page=2",
                                           :content => "Next")
      end

      it "should have delete links for microposts created by signed in user" do
        mp =  Factory(:micropost, :user => @user, :content => "Lorem Espera")
        get 'home'
        response.should have_selector("a", :href => "/microposts/"+mp.id.to_s,
                                           :content => "delete")
      end

      it "should not have delete links for microposts created by other users" do
        other_user = Factory(:user, :email => "another@example.edu")
        mp = Factory(:micropost, :user => other_user, :content => "Lorem Espera")
        get 'home'
        response.should_not have_selector("a", :href => "/microposts/"+mp.id.to_s,
                                               :content => "delete")
      end
    end
        
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
        :content => @base_title+"Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
        :content => @base_title+"About")
    end
  end
  
  describe "GET 'help'" do
    it "should be successful" do
      get'help'
      response.should be_success
    end
    it "should ahve the right title" do
      get 'help'
      response.should have_selector("title",
        :content => @base_title+"Help")
    end
  end
end
