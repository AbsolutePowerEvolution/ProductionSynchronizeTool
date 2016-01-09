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

  describe 'post /' do
    context 'when no event' do
      it 'responses 422' do
        post '/'
        expect(last_response.status).to eq(422)
      end
    end

    context 'when without body' do
      it 'will response 422' do
        header 'CONTENT_TYPE', 'application/json'
        header 'X_GITHUB_EVENT', 'push'
        post '/'
        expect(last_response.status).to eq(422)
      end
    end

    context 'with correct payload' do
      context 'when not master' do
        it %q(will response 200 and doesn't pull) do
          data = { ref: 'foo' }
          header 'CONTENT_TYPE', 'application/json'
          header 'X_GITHUB_EVENT', 'push'
          post '/', data.to_json

          expect(last_response.status).to eq(200)
        end
      end
    end
  end
end
