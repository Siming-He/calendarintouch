require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  CALENDAR = 'primary'

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end

    client = get_google_calendar_client current_user
    task = params[:task]
    event = get_event task
    client.insert_event('primary', event)
    flash[:notice] = 'Task was successfully added.'
    redirect_to edit_subject_path(params[:subject])

  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_google_calendar_client current_user
    client = Google::Apis::CalendarV3::CalendarService.new
    return unless (current_user.present? && current_user.access_token.present? && current_user.refresh_token.present?)
    secrets = Google::APIClient::ClientSecrets.new({
      "web" => {
        "access_token" => current_user.access_token,
        "refresh_token" => current_user.refresh_token,
        "client_id" => ENV["GOOGLE_API_KEY"],
        "client_secret" => ENV["GOOGLE_API_SECRET"]
      }
    })
    begin
      client.authorization = secrets.to_authorization
      client.authorization.grant_type = "refresh_token"

      if !current_user.present?
        client.authorization.refresh!
        current_user.update_attributes(
          access_token: client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at: client.authorization.expires_at.to_i
        )
      end
    rescue => e
      flash[:error] = 'Your token has been expired. Please login again with google.'
      redirect_to :back
    end
    client
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :duedate, :description, :subject_id)
    end

    def get_event task
      attendees = task[:members].split(',').map{ |t| {email: t.strip} }
      event = Google::Apis::CalendarV3::Event.new({
        summary: task[:title],
        location: 'Hanguang Rd., Xian, China L2R7C3',
        description: task[:description],
        start: {
          date_time: Time.new(task['start_date(1i)'],task['start_date(2i)'],task['start_date(3i)'],task['start_date(4i)'],task['start_date(5i)']).to_datetime.rfc3339,
          time_zone: "Asia/Kolkata"
          # date_time: '2019-09-07T09:00:00-07:00',
          # time_zone: 'Asia/Kolkata',
        },
        end: {
          date_time: Time.new(task['end_date(1i)'],task['end_date(2i)'],task['end_date(3i)'],task['end_date(4i)'],task['end_date(5i)']).to_datetime.rfc3339,
          time_zone: "Asia/Kolkata"
        },
        attendees: attendees,
        reminders: {
          use_default: false,
          overrides: [
            Google::Apis::CalendarV3::EventReminder.new(reminder_method:"popup", minutes: 10),
            Google::Apis::CalendarV3::EventReminder.new(reminder_method:"email", minutes: 20)
          ]
        },
        notification_settings: {
          notifications: [
                          {type: 'event_creation', method: 'email'},
                          {type: 'event_change', method: 'email'},
                          {type: 'event_cancellation', method: 'email'},
                          {type: 'event_response', method: 'email'}
                         ]
        }, 'primary': true
      })
    end

end
