class FilmMailer < ApplicationMailer
  def import_complete
    @user = params[:user]
    @film = params[:film]

    mail to: @user.email, subject: 'Film import complete!'
  end 
end
