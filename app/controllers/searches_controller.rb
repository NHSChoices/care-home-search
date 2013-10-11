class SearchesController < ApplicationController
  def new
    New.new(self).action
  end

  def create
    Create.new(self).action
  end

  def show
    Show.new(self).action
  end
end
