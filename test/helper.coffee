global.chai = require 'chai'
global.expect = require('chai').expect

sinonChai = require 'sinon-chai'
chaiAsPromised = require 'chai-as-promised'

chai.use(sinonChai)
chai.use(chaiAsPromised)
