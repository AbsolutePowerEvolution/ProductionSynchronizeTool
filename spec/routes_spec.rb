#!/usr/bin/env ruby
# encoding: UTF-8

require 'spec_helper'

describe 'Routes' do
  it "should allow accessing the home page" do
    get '/'
    expect(last_response).to be_ok
  end
end
