class Store < ApplicationRecord
  has_many :finances
  belongs_to :user

  validates :name, :owner, presence: true

  validates_length_of :owner, maximum: 14
  validates_length_of :name, maximum: 19

  def formatted_balance
    "R$ #{"%.2f" % balance}"
  end
end
