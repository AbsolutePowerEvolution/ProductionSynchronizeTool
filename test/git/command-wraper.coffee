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

  describe '#stash', ->
    it 'should resolve promise if success', ->
      NockExec("#{CommandWraper.GitCommand} stash").exit()
      expect(CommandWraper.stash(NockExec.moduleStub)).to.be.fulfilled
    it 'should reject promise if error', ->
      NockExec("#{CommandWraper.GitCommand} stash").exit(code: 1)
      expect(CommandWraper.stash(NockExec.moduleStub)).to.be.rejected

  describe '#stashPop', ->
    it 'should resolve promise if success', ->
      NockExec("#{CommandWraper.GitCommand} stash pop").exit()
      expect(CommandWraper.stashPop(NockExec.moduleStub)).to.be.fulfilled
    it 'should reject promise if error', ->
      NockExec("#{CommandWraper.GitCommand} stash pop").exit(code: 1)
      expect(CommandWraper.stashPop(NockExec.moduleStub)).to.be.rejected
