# frozen_string_literal: true

class SearchController < ApplicationController
  def new
    @find_any = true
  end

  def questions
    @questions = Question.search_for(fields, query, find_any)

    if @questions.empty?
      flash.now[:alert] = "No search results for query: #{question_params[:query]}"
      render :new
    else
      @search_result = true
      flash.now[:notice] = "Your search results"
      render "/questions/index"
    end
  rescue ArgumentError => e
    flash.now[:alert] = "Error: #{e.message}"
    render :new
  end

  private

  def fields
    fields = question_params.to_h.select { |k, v| Question::ALLOWED_SEARCH_FIELDS.include?(k.to_sym) && v.to_s == "1" }
    fields.keys.map(&:to_sym)
  end

  def find_any
    @find_any ||= question_params[:find_any_word] == "1"
  end

  def query
    @query ||= question_params[:query]
  end

  def question_params
    params.permit(:body, :title, :find_any_word, :query, :questions)
  end
end
