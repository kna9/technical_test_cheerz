class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # POST /users
  def create
    user_creation_result = User.create_with_free_pseudo(user_params[:pseudo])
    render json: user_creation_result, status: user_creation_result[:success] ? 201 : 500
  end

  private
    def user_params
      params.require(:user).permit(:pseudo)
    end
end
