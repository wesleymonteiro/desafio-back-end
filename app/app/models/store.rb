class Store < ApplicationRecord
  has_many :finances
  belongs_to :user

  validates :name, :owner, presence: true
end
