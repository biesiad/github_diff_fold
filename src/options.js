require('file?name=./build/[name].[ext]!./options.html')
require('file?name=./build/[name].[ext]!./icon.png')

var Elm = require('./Options.elm');

chrome.storage.sync.get({ values: [] }, function (data) {
  var options = Elm.Options.embed(document.body, data.values);

  options.ports.save.subscribe(function (values) {
    chrome.storage.sync.set({ values: values.filter(function (v) { return v !== "" }) });
  });
});
