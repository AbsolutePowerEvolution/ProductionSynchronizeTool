#!/usr/bin/env ruby
# encoding: UTF-8

require 'json'
require 'spec_helper'

describe 'Routes' do
  describe 'get /' do
    it 'allows accessing the home page' do
      get '/'
      expect(last_response).to be_ok
    end
  end

  describe 'post /'
    context 'when no event' do
      it 'responses 422' do
        post '/'
        expect(last_response.status).to eq(422)
      end
    end

    context 'when without body' do
      it 'should response 422 if ' do
        post '/', nil, 'Content-Type' => 'application/json', 'X-Github-Event' => 'push'
        expect(last_response.status).to eq(422)
      end
    end

    context 'when with correct payload' do
      it 'should response 200 if with correct payload' do
        data = {ref: 'foo'}
        post '/', data.to_json, 'Content-Type' => 'application/json', 'X-Github-Event' => 'push'
        expect(last_response.status).to eq(422)
      end
    end
end
