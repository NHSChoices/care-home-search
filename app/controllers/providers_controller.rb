class ProvidersController < ApplicationController
  def show
    Show.new(self).action
  end
end
