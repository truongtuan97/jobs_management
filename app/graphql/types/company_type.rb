# frozen_string_literal: true

module Types
  class CompanyType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :location, String, null: true
    field :description, String
    field :jobs, [Types::JobType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end