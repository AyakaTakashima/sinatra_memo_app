#! /usr/bin/env ruby
# frozen_string_literal: true

require 'sinatra'
require 'cgi'
require 'pg'

set :environment, :production

connection = PG.connect(host: 'localhost', user: 'takashimaayaka', password: '', dbname: 'web_application_practice')

# This is class to read memo data from database.
class Memo
  def self.all(connection)
    connection.exec('SELECT * FROM memo_data ORDER BY id')
  end

  def self.create_new(connection, title, text)
    connection.exec("INSERT INTO memo_data(title, text) VALUES ('#{title}','#{text}')")
  end

  def self.show(connection, id)
    connection.exec("SELECT id, title, text FROM memo_data WHERE id = #{id}") { |result| result[0] }
  end

  def self.update(connection, id, title, text)
    connection.exec("UPDATE memo_data SET title = '#{title}', text = '#{text}' WHERE id = #{id}")
  end

  def self.delete(connection, id)
    connection.exec("DELETE FROM memo_data WHERE id = #{id}")
  end
end

get '/memo' do
  @memo_data = Memo.all(connection)
  erb :top_page
end

get '/memo/new' do
  erb :create_new_memo
end

get '/memo/:id' do
  memo_id = params[:id].to_i

  @memo_data = Memo.show(connection, memo_id)

  erb :memo_page
end

get '/memo/:id/edit' do
  memo_id = params[:id].to_i
  @memo_data = Memo.show(connection, memo_id)

  erb :edit_page
end

post '/memo' do
  title = params[:title].gsub("'", "''")
  text = params[:text].gsub("'", "''")
  Memo.create_new(connection, title, text)

  redirect to('/memo')
end

patch '/memo/:id' do
  memo_id = params[:id].to_i
  title = params[:title].gsub("'", "''")
  text = params[:text].gsub("'", "''")
  Memo.update(connection, memo_id, title, text)

  redirect to('/memo')
end

delete '/memo/:id' do
  memo_id = params[:id].to_i
  Memo.delete(connection, memo_id)

  redirect to('/memo')
end

error 404 do
  erb :error_page
end
