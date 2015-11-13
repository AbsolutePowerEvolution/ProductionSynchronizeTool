NockExec = require 'nock-exec'

CommandWraper = require '../../lib/git/command-wraper'

describe 'CommandWraper', ->
  describe '#fetch', ->
    it 'should resolve promise if success', ->
      NockExec("#{CommandWraper.GitCommand} fetch origin").exit()
      expect(CommandWraper.fetch('origin', NockExec.moduleStub)).to.be.fulfilled
    it 'should reject promise if error', ->
      NockExec("#{CommandWraper.GitCommand} fetch origin")
        .exit({ code: 1 })
      expect(CommandWraper.fetch('origin', NockExec.moduleStub)).to.be.rejected
