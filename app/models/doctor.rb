# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  first_name      :string           not null
#  last_name       :string           not null
#  password_digest :string
#  type            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Doctor < User
end
