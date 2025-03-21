class AuditLog
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: Integer
  field :action, type: String
  field :details, type: Hash

  validates :user_id, presence: true
  validates :action, presence: true
end