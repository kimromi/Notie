class UsersController < ApplicationController
  before_action :set_user, only: [:setting]
  skip_before_action :verify_authenticity_token, only: [:setting]

  def setting
    return_result @user.update(key_shortcut: params["key_shortcut"])
  end

  private
    def set_user
      @user = User.where(["user_id = ? and auth = ?", session[:user_id], session[:auth_service]])[0]
    end

    def return_result(operation)
      if operation
        render :json => {result: 'success'}.to_json
      else
        render :json => {result: 'error'}.to_json
      end
    end
end
