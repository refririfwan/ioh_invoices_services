# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Sinatra App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  let(:invoices) { [] }

  before do
    $invoices = invoices
  end

  context 'POST /invoices' do
    it 'creates a new invoice' do
      invoice_data = {
        'user' => 'Test User',
        'due_date' => '2023-08-31',
        'total' => 100
      }

      post '/invoices', invoice_data.to_json, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response.status).to eq(201)
      expect(JSON.parse(last_response.body)['status']).to eq('success')
    end
  end

  context 'GET /invoices' do
    it 'returns a list of invoices' do
      get '/invoices'

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)['status']).to eq('success')
    end
  end

  context 'GET /invoices/:id' do
    it 'returns a specific invoice' do
      invoice_id = 'some_id'
      invoices << { id: invoice_id, user: 'Test User', total: 100 }

      get "/invoices/#{invoice_id}"

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)['status']).to eq('success')
      expect(JSON.parse(last_response.body)['data']['invoice']['id']).to eq(invoice_id)
    end

    it 'returns 404 for non-existent invoice' do
      get '/invoices/non_existent_id'

      expect(last_response.status).to eq(404)
      expect(JSON.parse(last_response.body)['message']).to eq('Invoice not found')
    end
  end

  context 'PUT /invoices/:id' do
    it 'updates an existing invoice' do
      invoice_id = 'some_id'
      invoices << { id: invoice_id, user: 'Test User', total: 100 }

      put "/invoices/#{invoice_id}", { 'total' => 150 }.to_json, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)['status']).to eq('success')
      expect(JSON.parse(last_response.body)['data']['total']).to eq(150)
    end

    it 'returns 404 for non-existent invoice' do
      put '/invoices/non_existent_id', { 'total' => 150 }.to_json, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response.status).to eq(404)
      expect(JSON.parse(last_response.body)['message']).to eq('Invoice not found')
    end
  end

  context 'DELETE /invoices/:id' do
    it 'deletes an existing invoice' do
      invoice_id = 'some_id'
      invoices << { id: invoice_id, user: 'Test User', total: 100 }

      delete "/invoices/#{invoice_id}"

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)['status']).to eq('success')
      expect(invoices.empty?).to be true
    end

    it 'returns 404 for non-existent invoice' do
      delete '/invoices/non_existent_id'

      expect(last_response.status).to eq(404)
      expect(JSON.parse(last_response.body)['message']).to eq('Invoice not found')
    end
  end
end
