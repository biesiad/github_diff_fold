require('file?name=./build/[name].[ext]!./options.html')

var Elm = require('./Options.elm');
Elm.Options.embed(document.body, [])
