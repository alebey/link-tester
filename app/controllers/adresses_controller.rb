class AdressesController < ApplicationController
  def index
    @adresses = Adress.paginate :page => params[:page], :order => 'created_at DESC'
  end

  def show
  end

end
