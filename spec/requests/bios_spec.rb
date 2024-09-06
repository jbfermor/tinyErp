require 'rails_helper'

RSpec.describe BiosController, type: :controller do
  let(:user) { create(:user) }
  let(:bio) { user.bio }

  before do
    sign_in user
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: bio.id }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    let(:valid_attributes) {
      { nif: '12345678A', commercial_name: 'MyCompany', contact_person: 'John Doe' }
    }

    let(:invalid_attributes) {
      { nif: '', commercial_name: '', contact_person: '' }
    }

    context 'with valid params' do
      it 'updates the requested bio' do
        put :update, params: { id: bio.id, bio: valid_attributes }
        bio.reload
        expect(bio.nif).to eq('12345678A')
      end

      it 'redirects to the root path' do
        put :update, params: { id: bio.id, bio: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "edit" template)' do
        put :update, params: { id: bio.id, bio: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
