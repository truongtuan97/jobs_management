class Api::V1::CompaniesController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_company, only: %i[show update destroy]

  def index
    companies = Company.all

    render json: { companies: companies }, status: :ok
  end

  def show
    render json: { company: @company }, status: :ok
  end

  def create
    company = Company.new(company_params)
    if company.save
      render json: { company: company }, status: :created
    else
      render json: { errors: company.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @company.update(company_params)
    if @company.save
      render json: { company: @company }, status: :ok
    else
      render json: { errors: @company.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @company.destroy
    head :no_content
  end

  private

  def set_company
    @company = Company.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "Record not found" }, status: :not_found
  end

  def company_params
    params.require(:company).permit(:name, :location, :description)
  end
end
