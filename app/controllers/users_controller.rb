class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show update destroy ]
  before_action :validate_params, only: %i[ update ]

  # GET /users
  def index
    @users = User.where.not(id: current_user).order(created_at: :desc)
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    tokens = @user.tokens.to_i + user_params["tokens"].to_i;
    new_token_value_for_loggend_user = current_user.tokens.to_i - user_params["tokens"].to_i;
    
    User.transaction do 
      logged_user_is_updated = current_user.update(tokens: new_token_value_for_loggend_user)
      user_is_updated = @user.update(tokens: tokens)
      
      if logged_user_is_updated && user_is_updated
        render json: @user
      else
        render json: "failed to update", status: :unprocessable_entity
      end

    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {})
    end

    def validate_params
      #verify value of tokens sents
      new_token_value_for_loggend_user = current_user.tokens.to_i - user_params["tokens"].to_i;

      if user_params["tokens"].to_i < 0 || new_token_value_for_loggend_user < 0
        render json: "invalid token value", status: :unprocessable_entity
      end
    end 
end
