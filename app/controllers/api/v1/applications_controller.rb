class Api::V1::ApplicationsController < ApplicationController
  before_action :authenticate_user!

  def index
    applications = current_user.applications.includes(:job)
    render json: { applications: applications.to_json(include: :job) }, status: :ok
  end

  def create
    application = current_user.applications.build(application_params)
    if application.save
      render json: { application: application }, status: :created
    else
      render json: { errors: application.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def application_params
    params.require(:application).permit(:job_id, :status)
  end
end
