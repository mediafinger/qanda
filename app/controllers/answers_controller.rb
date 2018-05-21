# frozen_string_literal: true

class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params.merge(user_id: current_user.id, question_id: params[:question_id]))

    if @answer.save
      flash[:notice] = "Answer was successfully created."
      redirect_to question_path(params[:question_id])
    else
      flash[:alert] = "Error: Answer not created."
      @question = Question.find(params[:question_id])
      render :new
    end
  end

  def new
  end

  private

  def answer_params
    params.require(:answer).permit(:title, :body)
  end
end
