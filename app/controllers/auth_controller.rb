class AuthController < ApplicationController

  def login
    provider = params[:provider]

    case provider
    when "qiita"
      redirect_to 'https://qiita.com/api/v2/oauth/authorize?client_id=' + @@Q_CLIENT_ID + '&scope=read_qiita+write_qiita&state=' + @@Q_STATE
    when "github"
      redirect_to 'https://github.com/login/oauth/authorize?client_id=' + @@G_CLIENT_ID
    end
  end

  def logout
    session[:token] = nil
    session[:user_id] = nil
    session[:user_name] = nil
    session[:auth_service] = nil
    redirect_to root_path
  end

  def callback
    provider = params[:provider]
    code = params[:code]

    case provider
    when "qiita"
      token = qiita_token(code)
      user = qiita_user(token["token"])
      session[:token] = token.to_s
      session[:user_id] = user["id"].to_s
      session[:user_name] = user["id"].to_s
      session[:auth_service] = "qiita"
      redirect_to "/app"
    when "github"
      token = github_token(code)
      user = github_user(token["access_token"])
      session[:token] = token.to_s
      session[:user_id] = user["id"].to_s
      session[:user_name] = user["login"].to_s
      session[:auth_service] = "github"
      redirect_to "/app"
    end

  end

end
