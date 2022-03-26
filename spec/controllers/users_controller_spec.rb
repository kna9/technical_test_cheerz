require 'rails_helper'

describe "create a user", :type => :request do
  context "with a too short pseudo" do
    before do
      create(:pseudo, pseudo: 'ZZZ')
      post '/users', params: { user: { pseudo: 'ZZ' }}
    end
  
    it 'returns an error' do
      expect(JSON.parse(response.body)['errors'].first).to eq('pseudo invalid must be 3 letters, uppercase, without special characters, without numbers')
    end

    it 'returns false success' do
      expect(JSON.parse(response.body)['success']).to eq(false)
    end

    it 'returns an error status' do
      expect(response).to have_http_status(500)
    end
  end

  context "with a wrong pseudo" do
    before do
      create(:pseudo, pseudo: 'ZZZ')
      post '/users', params: { user: { pseudo: 'Z543ESERZE$' }}
    end
  
    it 'returns an error' do
      expect(JSON.parse(response.body)['errors'].first).to eq('pseudo invalid must be 3 letters, uppercase, without special characters, without numbers')
    end

    it 'returns false success' do
      expect(JSON.parse(response.body)['success']).to eq(false)
    end

    it 'returns an error status' do
      expect(response).to have_http_status(500)
    end
  end

  context "create a user when there is no pseudo" do
    before do
      post '/users', params: { user: { pseudo: 'ZZZ' }}
    end
  
    it 'returns an error' do
      expect(JSON.parse(response.body)['errors'].first).to eq('pseudo does not exist')
    end

    it 'returns false success' do
      expect(JSON.parse(response.body)['success']).to eq(false)
    end

    it 'returns an error status' do
      expect(response).to have_http_status(500)
    end
  end

  context "create a user with pseudo that is not availlable" do
    before do
      create(:pseudo, pseudo: 'AAA')
      post '/users', params: { user: { pseudo: 'ZZZ' }}
    end
  
    it 'returns an error' do
      expect(JSON.parse(response.body)['errors'].first).to eq('pseudo does not exist')
    end

    it 'returns false success' do
      expect(JSON.parse(response.body)['success']).to eq(false)
    end

    it 'returns an error status' do
      expect(response).to have_http_status(500)
    end
  end

  context "create a user with pseudo when all pseudo are used" do
    before do
      create(:pseudo, pseudo: 'AAA')
      create(:pseudo, pseudo: 'BBB')
      create(:pseudo, pseudo: 'CCC')
      create(:user, pseudo: 'AAA')
      create(:user, pseudo: 'BBB')
      create(:user, pseudo: 'CCC')
      post '/users', params: { user: { pseudo: 'AAA' }}
    end
  
    it 'returns an error' do
      expect(JSON.parse(response.body)['errors'].first).to eq('pseudo is not availlable')
    end

    it 'returns false success' do
      expect(JSON.parse(response.body)['success']).to eq(false)
    end

    it 'returns an error status' do
      expect(response).to have_http_status(500)
    end
  end
  
  context "create a user when pseudo is availlable but user already exists" do
    before do
      create(:pseudo, pseudo: 'AAA')
      create(:pseudo, pseudo: 'BBB')
      create(:user, pseudo: 'AAA')
      post '/users', params: { user: { pseudo: 'AAA' }}
    end
  
    it 'returns created pseudo' do
      expect(JSON.parse(response.body)['pseudo']).to eq('BBB')
    end

    it 'returns true success' do
      expect(JSON.parse(response.body)['success']).to eq(true)
    end

    it 'returns a created status' do
      expect(response).to have_http_status(201)
    end
  end

  context "create a user when pseudo is availlable and no user" do
    before do
      create(:pseudo, pseudo: 'AAA')
      post '/users', params: { user: { pseudo: 'AAA' }}
    end

    it 'returns true success' do
      expect(JSON.parse(response.body)['success']).to eq(true)
    end
  
    it 'returns created pseudo' do
      expect(JSON.parse(response.body)['pseudo']).to eq('AAA')
    end

    it 'returns a created status' do
      expect(response).to have_http_status(201)
    end
  end

  context "create a user when pseudo is availlable and user is availlable" do
    before do
      create(:pseudo, pseudo: 'AAA')
      create(:pseudo, pseudo: 'BBB')
      create(:user, pseudo: 'AAA')
      post '/users', params: { user: { pseudo: 'BBB' }}
    end

    it 'returns true success' do
        expect(JSON.parse(response.body)['success']).to eq(true)
    end
  
    it 'returns created pseudo' do
      expect(JSON.parse(response.body)['pseudo']).to eq('BBB')
    end

    it 'returns a created status' do
      expect(response).to have_http_status(201)
    end
  end
end