class ProvidersController < ApplicationController
  class Show < Fendhal::Action

    def action
      render locals: { provider: provider }
    end

    def provider
      Provider::Request.new(params[:id]).result
    end

  end
end

