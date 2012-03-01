require File.dirname(__FILE__) + '/../spec_helper'

describe AddressesController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Address.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Address.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Address.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(address_url(assigns[:address]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Address.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Address.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Address.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Address.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Address.first
    response.should redirect_to(address_url(assigns[:address]))
  end

  it "destroy action should destroy model and redirect to index action" do
    address = Address.first
    delete :destroy, :id => address
    response.should redirect_to(addresses_url)
    Address.exists?(address.id).should be_false
  end
end
