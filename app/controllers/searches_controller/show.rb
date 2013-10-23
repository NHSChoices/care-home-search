class SearchesController < ApplicationController
  class Show < Fendhal::Action

    def action
      render locals: { search: search, results: results }
    rescue Search::APIError => e
      search.errors[:base] = I18n.t(:fail_whale, scope: :error)
      render :new, locals: { search: search }
    end

    def search
      @search ||= Search.new(postcode: params[:id])
    end

    def results
      search.results
    end

  end
end
