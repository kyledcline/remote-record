class IncomeType
  include Seedable
  seedable_from :rolodex, fallbacks: true, nested_key: :subtypes
end
