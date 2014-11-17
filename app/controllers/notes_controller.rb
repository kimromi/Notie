class NotesController < ApplicationController
  layout false
  before_action :set_user, only: [:page, :index, :create]
  before_action :set_note, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:download]
  
  def page
    if session[:auth_service].blank?
      redirect_to "/"
    end

    if !@user
      # register user
      @user = User.create(user_id: session[:user_id], auth: session[:auth_service])
    end
    @user_name = session[:user_name]
  end

  def index
    data = {user: @user, notes: @user.note}
    render :json => data.to_json(:methods => :tag_list)
  end

  def show
    render :json => @note.to_json(:methods => :tag_list)
  end

  def create
    @note = @user.note.build(note_params)
    @note.tag_list = params[:tag_list]
    @note.auth = session[:auth_service]

    return_result @note.save
  end

  def update
    @note.tag_list = params[:tag_list]
    return_result @note.update(note_params)
  end

  def destroy
    @note.destroy
    return_result true
  end

  def tag
    @note.destroy
    return_result true
  end

  def download
    param = params[:data].permit(:title, :content)
    send_data param[:content],:type => 'text/plain', :filename => param[:title]+'.txt'
  end

  private
    def set_user
      @user = User.where(["user_id = ? and auth = ?", session[:user_id], session[:auth_service]])[0]
    end

    def note_params
      params[:note].permit(:title, :content)
    end

    def set_note
      @note = Note.find(params[:id])
    end

    def return_result(operation)
      if operation
        render :json => {result: 'success', id: @note.id, uid: @note.uid}.to_json
      else
        render :json => {result: 'error'}.to_json
      end
    end
end
