class Api::V1::JobsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_job, only: %i[show update destroy]

  def index
    jobs = Job.cached_jobs
    # jobs = Job.includes(:company).all
    render json: {jobs: jobs.to_json(include: :company) }, status: :ok
  end

  def show
    render json: { job: @job.to_json(include: :company) }, status: ok
  end

  def create
    job = current_user.jobs.build(job_params)
    if job.save
      JobNotificationJob.perform_later(job.id)
      render json: {job: job }, status: :created
    else
      render json: { errors: job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @job.update(job_params)
      render json: { job: @job }, status: :ok
    else
      render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy
    head :no_content
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :salary, :company_id)
  end
end
