class RegistrationController < ApplicationController
  before_action :set_subject
  before_action :set_user
  before_action :authenticate_user!

end
