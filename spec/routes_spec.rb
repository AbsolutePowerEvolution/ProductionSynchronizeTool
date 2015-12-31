#!/usr/bin/env ruby
# encoding: UTF-8

require 'json'
require 'spec_helper'

describe 'Routes' do
  it 'should allow accessing the home page' do
    get '/'
    expect(last_response).to be_ok
  end

  describe 'post /'
    it 'should response 422 if without event' do
      post '/'
      expect(last_response.status).to eq(422)
    end

    it 'should response 422 if without body' do
      post '/', nil, 'Content-Type' => 'application/json', 'X-Github-Event' => 'push'
      expect(last_response.status).to eq(422)
    end

    it 'should response 200 if with correct payload' do
      data = {ref: 'foo'}
      post '/', data.to_json, 'Content-Type' => 'application/json', 'X-Github-Event' => 'push'
      expect(last_response.status).to eq(422)
    end
end
