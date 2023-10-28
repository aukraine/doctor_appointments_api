class OnlyIdContract < BaseContract
  params { required(:id).filled(:integer) }
end
