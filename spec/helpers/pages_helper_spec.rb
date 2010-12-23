require 'spec_helper'

describe PagesHelper do
  describe "render_sidebar_content" do
    it "should render controller action sidebar only" do
      page = Factory(:page, :name => "posts-index-sidebar", :body => "page1")
      helper.params[:controller] = 'posts'
      helper.params[:action] = 'index'
      helper.render_sidebar_content.should == "page1"
    end

    it "should render controller action sidebar with controller sidebar" do
      page1 = Factory(:page, :name => "posts-index-sidebar", :body => "page1")
      page2 = Factory(:page, :name => "posts-sidebar", :body => "page2")
      helper.params[:controller] = 'posts'
      helper.params[:action] = 'index'
      helper.render_sidebar_content.should == "page1page2"
    end

    it "should render controller action sidebar with controller form sidebar" do
      page1 = Factory(:page, :name => "posts-new-sidebar", :body => "page1")
      page2 = Factory(:page, :name => "posts-form-sidebar", :body => "page2")
      helper.params[:controller] = 'posts'
      helper.params[:action] = 'new'
      helper.render_sidebar_content.should == "page1page2"
    end
  end
end
