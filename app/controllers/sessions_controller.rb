class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    # Используйте `find_by` и аутентификацию отдельно
    @user = User.find_by(email: params[:email])
  
    Rails.logger.debug(@user)  # Логируем пользователя для отладки
  
    if @user&.authenticate(params[:password])  # Проверяем существование пользователя и аутентификацию
      login(@user)  # Предполагается, что у вас есть метод `login`
      redirect_to root_path, notice: "You have signed in successfully."
    else
      flash.now[:alert] = "Invalid email or password."  # Уведомление об ошибке на текущей странице
      render :new, status: :unprocessable_entity  # Рендерим форму с ошибкой
    end
  end

  def destroy
    logout current_user
    redirect_to root_path, notice: "You have been logged out."
  end
end
