class FinancesController < ApplicationController
  def index
    @stores = Store.where(user: current_user).includes(:finances)
  end

  def new
  end

  def create
    cnab = params[:finances][:file].read
    movements = []
    cnab.each_line do |line|
      movements << line
    end
    movements.each do |movement|
      kind = movement[0, 1].to_i
      data = movement[1, 8].insert(6, '-').insert(4, '-')
      value = movement[9, 10].to_f / 100.0
      cpf = movement[19, 11]
      card_number = movement[30, 12]
      hour = movement[42, 6].insert(4, ':').insert(2, ':')
      datetime = "#{data} #{hour} -3".to_datetime

      store_owner = movement[48, 14]
      store_name = movement[62, 19]
      store = Store.find_or_create_by(name: store_name, owner: store_owner, user: current_user)

      finance = Finance.new(kind: kind, movement_datetime: datetime, value: value,
                            cpf: cpf, card_number: card_number, store_id: store.id)
      if finance.valid?
        finance.save
        store.balance += is_kind_an_exit?(kind) ? -value : value
        store.save
      else
        puts finance.errors
        flash[:error] = "Erro, tente novamente mais tarde."
        redirect_to finances_path
        return
      end
    end
    flash[:notice] = "Movimentos financeiros criados com sucesso!"
    redirect_to finances_path
  end

  private
  def is_kind_an_exit?(kind)
    kind == 2 || kind == 3 || kind == 9
  end
end
