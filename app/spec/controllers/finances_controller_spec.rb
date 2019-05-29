require "rails_helper"

RSpec.describe FinancesController, type: :controller do
  before(:each) do
    user = User.create(email: "user@email.com", password: "password", password_confirmation:"password")
    allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
  end

  describe "GET #index" do
    before { get :index }

    it { expect(response).to have_http_status(302) }
  end

  describe "POST #create" do
    context "when params is not valid" do
      before { post :index }

      it { expect(Finance.count).to eql(0) }
    end

    context "when params is valid" do
      let(:file) { Rack::Test::UploadedFile.new(Rails.root.join("../", "CNAB.txt")) }
      
      before do
        post :index, params: { finances: { file: file } }
      end

      it { expect(Finance.count).to be >= 0 }
    end
  end

end
