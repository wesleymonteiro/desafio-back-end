class FinancesController < ApplicationController
  def index
    @stores = Store.all.includes(:finances)
  end

  def new
  end

  def create
  end
end
