# frozen_string_literal: true

class QuestionsController < ApplicationController
  def create
    @question = Question.new(question_params.merge(user_id: current_user.id))

    if @question.save
      flash[:notice] = "Question was successfully created."
      redirect_to "/questions#index"
    else
      flash[:alert] = "Error: Question not created."
      render :new
    end
  end

  def index
    @questions = Question.all # TODO: add limit / pagination
  end

  def new
    @question = Question.new(user_id: current_user.id)
  end

  private

  def question_params
    params.permit(:title, :body)
  end
end
