class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, except: [:index, :new, :create]

  skip_before_action :authenticate, only: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    if signed_in_user?
      redirect_to user_path(current_user), notice: "Already signed in"
    else
      @user = User.new
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(whitelisted_user_params)
    respond_to do |format|
      if @user.save
        sign_in(@user)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(whitelisted_user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    sign_out
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  private
    def correct_user
      unless params[:id] == current_user.id.to_s
        flash[:danger] = "You're not authorized to view this"
        redirect_to user_path(current_user)
      end
    end

    def set_user
      @user = User.find(params[:id])
    end

end
