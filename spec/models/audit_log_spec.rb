require 'rails_helper'

RSpec.describe AuditLog, type: :model do
  let(:audit_log) { create(:audit_log) }

  it 'can create a valid auditlog' do
    expect(audit_log).to be_valid
  end

  it 'action is required' do
    audit_log.action = nil
    expect(audit_log).not_to be_valid
  end

  it 'user id is required' do
    audit_log.user_id = nil
    expect(audit_log).not_to be_valid
  end
end