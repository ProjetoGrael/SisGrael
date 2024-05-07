class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :ban]
  load_and_authorize_resource
  
  # GET /users
  # GET /users.json
  def index
    if params[:term]
      @users = User.where(banned?: false).where("name ILIKE (?)", "%#{params[:term]}%").order('LOWER(name)').paginate(:page => params[:page], :per_page => 20)
    else
      @users = User.where(banned?: false).order('LOWER(name)').paginate(:page => params[:page], :per_page => 20)
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        if @user.instructor? && @user.teacher.blank?
          format.html { redirect_to new_user_teacher_path(@user), notice: 'Usuário criado! Preencha o cadastro de Educador.' }
        else
          format.html { redirect_to @user, notice: 'Usuário criado com sucesso.' }
          format.json { render :show, status: :created, location: @user }
        end
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    # Se alguma foto for enviada, remover a anterior:
    unless params[:user][:picture].nil?
      @user.remove_picture!
      @user.save
    end

    respond_to do |format|
      if @user.update(user_params_update(params[:user][:password]))
        bypass_sign_in @user  if current_user==@user
        format.html { redirect_to @user, notice: 'Usuário atualizado com sucesso.' }
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
    # Removendo a imagem do BD antes de deletá-lo:
    @user.remove_picture!
    @user.save

    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Usuário excluído com sucesso.' }
      format.json { head :no_content }
    end
  end

  def ban
    if (Academic::Teacher.find_by(user_id: @user.id))
      @user.teacher.update_attributes(active: false)
    end
    @user.update_attributes(banned?: true)
    # sign_out @user
    redirect_to users_path
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    #Igual a função user_params, mas caso o usuário não informe a senha, a atualização não será "barrada"
    def user_params_update(password)
      if password == ""
        if can? :manage, User
          params.require(:user).permit(:name, :email, :picture, :kind, :signature)
        else
          params.require(:user).permit(:name, :email, :picture, :signature)
        end
      else 
        if can? :manage, User
          params.require(:user).permit(:name, :email, :password, :picture, :kind, :signature)
        else
          params.require(:user).permit(:name, :email, :password, :picture, :signature)
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      if can? :manage, User
        params.require(:user).permit(:name, :email, :password, :picture, :kind, :signature)
      else
        params.require(:user).permit(:name, :email, :password, :picture, :signature)
      end
    end
end

