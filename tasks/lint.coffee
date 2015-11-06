gulp = require 'gulp'
path = require 'path'
lodash = require 'lodash'
loadPlugins = require 'gulp-load-plugins'

$ = loadPlugins()

SOURCE_PATH = [
  './src/**',
  './task/**',
  './test/**'
]

JS_PATH = lodash.map SOURCE_PATH, (src) ->
  "./#{path.join(src, '*.js')}"

COFFEE_PATH = lodash.map SOURCE_PATH, (src) ->
  "./#{path.join(src, '*.coffee')}"

gulp.task 'lint', ['coffee-lint', 'js-lint']

gulp.task 'coffee-lint', ->
  gulp.src COFFEE_PATH
    .pipe $.coffeelint()
    .pipe $.coffeelint.reporter('coffeelint-stylish')
    .pipe $.coffeelint.reporter('fail')

gulp.task 'js-lint', ->
  gulp.src JS_PATH
    .pipe $.jshint()
    .pipe $.jshint.reporter('jshint-stylish')
    .pipe $.jshint.reporter('fail')
