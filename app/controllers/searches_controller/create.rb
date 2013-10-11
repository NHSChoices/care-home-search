class SearchesController < ApplicationController
  class Create < Fendhal::Action

    def action
      search.valid? ? success : failure
    end

    def success
      redirect_to search_path(search)
    end

    def failure
      render :new, locals: { search: search }
    end

    def search
      @search ||= Search.new(params[:search])
    end

  end
end
