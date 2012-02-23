class AddressController < ApplicationController

  def new
    @address = Address.new
  end

  def update
  end
 
  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to 
  end
end
