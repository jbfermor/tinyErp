require 'rails_helper'

RSpec.describe BioService, type: :service do
  let(:user) { create(:user) }
  let(:valid_attributes) {
    { nif: '12345678A', commercial_name: 'MyCompany', contact_person: 'John Doe' }
  }

  describe '.create_for_user' do
    it 'creates a bio for the user' do
      expect {
        BioService.create_for_user(user)
      }.to change(Bio, :count).by(1)
    end
  end

  describe '.update_bio' do
    let(:bio) { create(:bio, user: user) }

    it 'updates the bio' do
      BioService.update_bio(bio, valid_attributes)
      bio.reload
      expect(bio.nif).to eq('12345678A')
      expect(bio.commercial_name).to eq('MyCompany')
    end
  end
end
