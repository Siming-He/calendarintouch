class RegistrationController < ApplicationController
  before_action :set_subject
  before_action :set_user
  before_action :authenticate_user!
  before_action :ensure_public, only: [:add_subject, :drop_subject]

  def add_subject
    if !@subject.private && !@subject.get_users.include?(@user)
      @subject.get_users << @user
      @subject.user_add = @user
    end
    redirect_to subjects_path	
  end

  def drop_subject
    if @subject.get_users.include?(@user)
      @subject.get_users.delete_at(@subject.get_users.index(@user))
      @subject.user_drop = @user
    end
    redirect_to subjects_path	
  end

  private

  def set_subject
    @subject = Subject.find(params[:subject_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def ensure_public
    redirect_to subjects_path unless !@subject.private
  end
end
