class SearchesController < ApplicationController
  class New < Fendhal::Action

    def action
      render locals: { search: search }
    end

    def search
      Search.new
    end

  end
end
