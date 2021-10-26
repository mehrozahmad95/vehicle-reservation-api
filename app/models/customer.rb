# == Schema Information
#
# Table name: customers
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :string
#
# Indexes
#
#  index_customers_on_customer_id  (customer_id)
#
class Customer < ApplicationRecord
  #-------------------------------------------------------------------------------------------------
  # VALIDATIONS
  #-------------------------------------------------------------------------------------------------
  validates :customer_id, presence: true
  #-------------------------------------------------------------------------------------------------
  # ASSOCIATIONS
  #-------------------------------------------------------------------------------------------------
  has_many :vehicles
  has_many :reservations
end
