# frozen_string_literal: true

module Types
  class JobType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :description, String
    field :salary, Float
    field :company, Types::CompanyType, null: false
    field :user, Types::UserType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
