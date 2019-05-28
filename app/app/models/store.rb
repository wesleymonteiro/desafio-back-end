class Store < ApplicationRecord
  has_many :finances

  validates :name, :owner, presence: true
end
