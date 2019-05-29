require 'rails_helper'

RSpec.describe Finance, type: :model do
  describe "validations" do
    it { should validate_presence_of :kind }
    it { should validate_presence_of :movement_datetime }
    it { should validate_presence_of :value }
    it { should validate_presence_of :cpf }
    it { should validate_presence_of :card_number }
    it { should validate_presence_of :store }
    it { should validate_length_of(:cpf).is_equal_to(11) }
    it { should validate_length_of(:card_number).is_equal_to(12) }
  end

  describe "relationships" do
    it { should belong_to(:store) }
  end

  describe "methods" do
    before do
      @user = User.create(email: "user@email.com", password: "password", password_confirmation:"password")
      @store = Store.create(name: "test's store", owner: 'Sir Test', user: @user)
      @finance = Finance.create(kind: 1, movement_datetime: '14-11-2016 22:00'.to_datetime, value: 100, cpf: "12345678910",
                                card_number: "1234****5678", store: @store)
    end

    describe "#formatted_cpf" do
      it { expect(@finance.formatted_cpf).to eql("123.456.789-10") }
    end

    describe "#formatted_card_number" do
      it { expect(@finance.formatted_card_number).to eql("1234-****-5678") }
    end

    describe "#formatted_movement_datetime" do
      it { expect(@finance.formatted_movement_datetime).to eql("14/11/2016 22:00") }
    end

    describe "#formatted_value" do
      it { expect(@finance.formatted_value).to eql("R$ 100.00") }
    end
  end
end
