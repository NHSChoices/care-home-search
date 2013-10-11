class SearchesController < ApplicationController
  class New < Fendhal::Action

    def action
      render locals: { search: search }
    end

    def search
      Search.new.as_form
    end

  end
end
