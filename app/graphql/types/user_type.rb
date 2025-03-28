# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String
    field :name, String
    field :role, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    # field :encrypted_password, String, null: false
    # field :reset_password_token, String
    # field :reset_password_sent_at, GraphQL::Types::ISO8601DateTime
    # field :remember_created_at, GraphQL::Types::ISO8601DateTime
    # field :jti, String, null: false
  end
end
