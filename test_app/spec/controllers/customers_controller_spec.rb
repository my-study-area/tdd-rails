require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe 'as a Guest' do
    context '#index' do
      it 'responds successfully' do
        get :index
        expect(response).to be_successful
      end

      it 'responds a 200 response' do
        get :index
        expect(response).to have_http_status(200)
      end
    end

    it 'responds a 302 response (not authorized)' do
      customer = create(:customer)
      get :show, params: { id: customer.id }
      expect(response).to have_http_status(302)
    end
  end

  describe 'as Logged Member' do
    before(:each) do
      @member = create(:member)
      @customer = create(:customer)
    end


    it 'responds a 200 response' do
      sign_in @member
      get :show, params: { id: @customer.id }
      expect(response).to have_http_status(200)
    end

    it 'render a :show template' do
      sign_in @member
      get :show, params: { id: @customer.id }
      expect(response).to render_template(:show)
    end
    
    it 'with valid attributes' do
      sign_in @member
      customer_params = attributes_for(:customer)
      expect {
        post :create, params: { customer: customer_params }
      }.to change(Customer, :count).by(1)
    end
  end
end
