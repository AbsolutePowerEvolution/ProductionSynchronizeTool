NodeConfig = require 'config'
Sinon = require 'sinon'

ConfigKeys = [
  'url',
  'path',
  'address',
  'port'
]

describe 'Config', ->
  it 'should throw when it could not found config', ->
    stub = Sinon.stub(NodeConfig, 'has')
    stub.returns(false)

    expect(require.bind require, '../lib/config').to
      .throw(Error)

    stub.restore()

  it 'should load config', ->
    stubHas = Sinon.stub(NodeConfig, 'has')
    stubGet = Sinon.stub(NodeConfig, 'get')

    for k in ConfigKeys
      stubHas.withArgs(k).returns(true)
      stubGet.withArgs(k).returns(k)

    config = require '../lib/config'
    for k in ConfigKeys
      expect(config[k]).to.equal(k)

    stubHas.restore()
    stubGet.restore()
