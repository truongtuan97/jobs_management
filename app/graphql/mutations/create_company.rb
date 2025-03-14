module Mutations
  class CreateCompany < Mutations::BaseMutation
    argument :name, String, required: true
    argument :location, String, required: false

    field :company, Types::CompanyType, null: false
    field :errors, [String], null: false

    def resolve(name:, location: nil)
      company = Company.new(name: name, location: location)
      if company.save
        { company: company, errors: [] }
      else
        { company: nil, errors: company.errors.full_messages }
      end
    end
  end
end
