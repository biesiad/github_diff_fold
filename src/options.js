require('file?name=./build/[name].[ext]!./options.html')
require('file?name=./build/[name].[ext]!./icon.png')

var Elm = require('./Options.elm');
Elm.Options.embed(document.body, [])
