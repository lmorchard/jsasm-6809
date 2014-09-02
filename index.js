var util = require('util');
var fs = require("fs");

var _ = require('lodash');

var PEG = require("pegjs"),
    parser_fn = __dirname + '/lib/asm-6809.pegjs',
    parser_src = fs.readFileSync(parser_fn, 'utf8'),
    parser = PEG.buildParser(parser_src);

exports.parser = parser;
