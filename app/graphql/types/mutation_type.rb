# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_job, mutation: Mutations::CreateJob
    field :create_company, mutation: Mutations::CreateCompany
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end
  end
end
