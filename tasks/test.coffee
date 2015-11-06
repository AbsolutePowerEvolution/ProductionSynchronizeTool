gulp = require 'gulp'
loadPlugins = require 'gulp-load-plugins'

$ = loadPlugins()

gulp.task 'test', ->
  gulp.src './test/**/*.coffee'
    .pipe $.mocha()

