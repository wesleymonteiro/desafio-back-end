require 'rails_helper'

RSpec.describe Store, type: :model do
  describe "validations" do
    it { should validate_presence_of :owner }
    it { should validate_presence_of :name }
    it { should validate_presence_of :user }
    it { should validate_length_of(:owner).is_at_most(14) }
    it { should validate_length_of(:name).is_at_most(19) }
  end

  describe "relationships" do
    it { should belong_to(:user) }
    it { should have_many(:finances) }
  end

  describe "methods" do
    before do
      @user = User.create(email: "user@email.com", password: "password", password_confirmation:"password")
      @store = Store.create(name: "test's store", owner: 'Sir Test', user: @user, balance: 4500)
    end

    describe "#formatted_balance" do
      it { expect(@store.formatted_balance).to eql("R$ 4500.00") }
    end
  end
end
