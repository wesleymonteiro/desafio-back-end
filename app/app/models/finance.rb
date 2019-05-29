class Finance < ApplicationRecord
  belongs_to :store

  validates :store, :kind, :cpf, :card_number, :movement_datetime, :value, presence: true

  validates_length_of :cpf, is: 11
  validates_length_of :card_number, is: 12

  enum kind: { Débito: 1, Boleto: 2, Financiamento: 3, Crédito: 4, "Recebimento Empréstimo": 5,
               Vendas: 6, "Recebimento TED": 7, "Recebimento DOC": 8, Aluguel: 9 }

  default_scope { order(movement_datetime: :desc) }

  def formatted_cpf
    number = cpf
    number.insert(9, '-')
    number.insert(6, '.')
    number.insert(3, '.')
  end

  def formatted_card_number
    number = card_number
    number.insert(8, '-')
    number.insert(4, '-')
  end

  def formatted_movement_datetime
    movement_datetime.strftime('%d/%m/%Y %H:%M')
  end

  def formatted_value
    "R$ #{"%.2f" % value}"
  end
end
