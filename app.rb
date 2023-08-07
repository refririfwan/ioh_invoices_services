# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'nanoid'
require 'json'
require 'securerandom'

$invoices = []

post '/invoices' do
  content_type :json
  data = JSON.parse(request.body.read)
  id = Nanoid.generate
  invoice_number = "INV#{SecureRandom.hex(10)}".upcase
  time = Time.now
  invoice = {
    id: id,
    user: data['user'],
    invoice_number: invoice_number,
    due_date: data['due_date'],
    total: data['total'],
    created_at: time,
    updated_at: time
  }

  $invoices << invoice

  inv = $invoices.select { |i| i[:id] == id }

  halt(500, { status: 'fail', message: 'Failed add invoice' }.to_json) unless inv

  data_res = { id: id, invoice_number: invoice_number }

  status 201
  response = {
    status: 'success',
    message: 'Success add invoice',
    data: data_res
  }.to_json
  body response
end

get '/invoices' do
  content_type :json

  data = $invoices

  status 200
  response = {
    status: 'success',
    data: {
      invoices: data
    }
  }.to_json
  body response
end

get '/invoices/:id' do
  content_type :json
  id = params[:id]
  invoice = $invoices.find { |i| i[:id] == id }
  halt(404, { message: 'Invoice not found' }.to_json) unless invoice

  status 200
  response = {
    status: 'success',
    data: {
      invoice: invoice
    }
  }.to_json
  body response
end

put '/invoices/:id' do
  content_type :json
  id = params[:id]
  data = JSON.parse(request.body.read)

  invoice = $invoices.find { |i| i[:id] == id }

  halt(404, { message: 'Invoice not found' }.to_json) unless invoice

  updated_invoice = invoice.merge(total: data['total'])

  $invoices.map! { |inv| inv[:id] == id ? updated_invoice : inv }

  invoice = $invoices.find { |i| i[:id] == id }

  status 200
  response = {
    status: 'success',
    data: invoice
  }.to_json
  body response
end

delete '/invoices/:id' do
  content_type :json
  id = params[:id]

  invoice_index = $invoices.find_index { |i| i[:id] == id }

  halt(404, { message: 'Invoice not found' }.to_json) unless invoice_index

  $invoices.delete_at(invoice_index)

  status 200
  response = { status: 'success', message: 'Invoice deleted' }.to_json
  body response
end
