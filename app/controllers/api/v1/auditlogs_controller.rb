class Api::V1::AuditlogsController < ApplicationController
  before_action :authenticate_user!

  def index
    logs = AuditLog.order_by(created_at: :desc).limit(50)
    render json: { logs: logs }, status: :ok
  end

end
