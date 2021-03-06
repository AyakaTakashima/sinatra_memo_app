#! /usr/bin/env ruby
# frozen_string_literal: true

require 'sinatra'
require 'cgi'
require 'json'

set :environment, :production

# This is class to read memo data from json file.
class Memo
  def self.all
    File.open('memos.json', 'r') do |file|
      read_line = file.read
      JSON.parse(read_line)
    end
  end

  def self.update(memo_data)
    File.open('memos.json', 'w') do |f|
      JSON.dump(memo_data, f)
    end
  end
end

get '/memo' do
  @memo_data = Memo.all
  erb :top_page
end

get '/memo/new' do
  erb :create_new_memo
end

get '/memo/:hash_order' do
  hash_order = params[:hash_order].to_i
  @hash_order = hash_order

  memo_data = Memo.all
  @memo = memo_data[hash_order]

  erb :memo_page
end

get '/memo/:hash_order/edit' do
  hash_order = params[:hash_order].to_i
  @hash_order = hash_order
  memo_data = Memo.all
  @memo = memo_data[hash_order]

  erb :edit_page
end

post '/memo' do
  memo_data = Memo.all
  memo_data << { title: params[:title], text: params[:text] }
  Memo.update(memo_data)

  redirect to('/memo')
end

patch '/memo/:hash_order' do
  hash_order = params[:hash_order].to_i
  memo_data = Memo.all
  memo_data.delete_at(hash_order)

  new_memo_data = { title: params[:title], text: params[:text] }
  memo_data.insert(hash_order, new_memo_data)
  Memo.update(memo_data)

  redirect to('/memo')
end

delete '/memo/:hash_order' do
  hash_order = params[:hash_order].to_i
  memo_data = Memo.all

  memo_data.delete_at(hash_order)
  Memo.update(memo_data)

  redirect to('/memo')
end

error 404 do
  erb :error_page
end
