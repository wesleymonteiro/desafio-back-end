class FinancesController < ApplicationController
  def index
    @stores = Store.all.includes(:finances)
  end

  def new
  end

  def create
    puts params[:file]
    cnab = File.open(params[:file])
  end
end
