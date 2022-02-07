#! /usr/bin/env ruby
# frozen_string_literal: true

require 'sinatra'
require 'cgi'
require 'pg'

set :environment, :production

# This is class to read memo data from database.
class Memo
  CONNECTION = PG.connect(host: 'localhost', user: 'takashimaayaka', password: '', dbname: 'web_application_practice')

  def self.all
    CONNECTION.exec('SELECT * FROM memo_data ORDER BY id')
  end

  def self.create_new(title, text)
    CONNECTION.exec('INSERT INTO memo_data(title, text) VALUES ($1, $2)', [title, text])
  end

  def self.show(id)
    CONNECTION.exec('SELECT id, title, text FROM memo_data WHERE id = $1', [id]) { |result| result[0] }
  end

  def self.update(id, title, text)
    CONNECTION.exec('UPDATE memo_data SET title = $1, text = $2 WHERE id = $3', [title, text, id])
  end

  def self.delete(id)
    CONNECTION.exec('DELETE FROM memo_data WHERE id = $1', [id])
  end
end

get '/memo' do
  @memo_data = Memo.all
  erb :top_page
end

get '/memo/new' do
  erb :create_new_memo
end

get '/memo/:id' do
  memo_id = params[:id].to_i

  @memo_data = Memo.show(memo_id)

  erb :memo_page
end

get '/memo/:id/edit' do
  memo_id = params[:id].to_i
  @memo_data = Memo.show(memo_id)

  erb :edit_page
end

post '/memo' do
  title = params[:title].gsub("'", "''")
  text = params[:text].gsub("'", "''")
  Memo.create_new(title, text)

  redirect to('/memo')
end

patch '/memo/:id' do
  memo_id = params[:id].to_i
  title = params[:title].gsub("'", "''")
  text = params[:text].gsub("'", "''")
  Memo.update(memo_id, title, text)

  redirect to('/memo')
end

delete '/memo/:id' do
  memo_id = params[:id].to_i
  Memo.delete(memo_id)

  redirect to('/memo')
end

error 404 do
  erb :error_page
end
