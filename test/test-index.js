/* jshint expr: true */
/* global chai, before, describe, it */
process.env.NODE_ENV = 'test';

var util = require('util');
var fs = require('fs');
var expect = require('chai').expect;

var jsasm = require(__dirname + '/../index');
var parser = jsasm.parser;

var FIXTURES_PATH = __dirname + '/fixtures';
function f (name) {
  return FIXTURES_PATH + '/' + name;
}

describe('play', function () {

  it('should parse an AS09 .asm file', function (done) {
    // var src = fs.readFileSync(f('sample.asm'), {encoding: 'utf8'});
    var src = fs.readFileSync(f('thrust/Thrust.asm'), {encoding: 'utf8'});

    var tokens = [];
    try {
      tokens = parser.parse(src).filter(function (t) {
        return t.type != 'COMMENT';
      });
      util.debug(util.inspect(tokens, {depth: null}));
    } catch (e) {
      util.debug(e);
    }

    return done();
  });

});
