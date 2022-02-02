#! /usr/bin/env ruby
# frozen_string_literal: true

require 'sinatra'
require 'cgi'
require 'pg'

set :environment, :production

# This is class to read memo data from database.
class Memo
  def self.all
    connection = PG.connect(host: 'localhost', user: 'takashimaayaka', password: '', dbname: 'web_application_practice')
    connection.exec('SELECT * FROM memo_data ORDER BY id')
  end

  def self.create_new(title, text)
    connection = PG.connect(host: 'localhost', user: 'takashimaayaka', password: '', dbname: 'web_application_practice')
    connection.exec("INSERT INTO memo_data(title, text) VALUES ('#{title}','#{text}')")
  end

  def self.show(id)
    connection = PG.connect(host: 'localhost', user: 'takashimaayaka', password: '', dbname: 'web_application_practice')
    connection.exec("SELECT id, title, text FROM memo_data WHERE id = #{id}") { |result| result[0] }
  end

  def self.update(id, title, text)
    connection = PG.connect(host: 'localhost', user: 'takashimaayaka', password: '', dbname: 'web_application_practice')
    connection.exec("UPDATE memo_data SET title = '#{title}', text = '#{text}' WHERE id = #{id}")
  end

  def self.delete(id)
    connection = PG.connect(host: 'localhost', user: 'takashimaayaka', password: '', dbname: 'web_application_practice')
    connection.exec("DELETE FROM memo_data WHERE id = #{id}")
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
  title = params[:title].gsub("'","''")
  text = params[:text].gsub("'","''")
  Memo.create_new(title, text)

  redirect to('/memo')
end

patch '/memo/:id' do
  memo_id = params[:id].to_i
  title = params[:title].gsub("'","''")
  text = params[:text].gsub("'","''")
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
