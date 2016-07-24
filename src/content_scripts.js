require('file?name=./build/[name].[ext]!./manifest.json')

var Elm = require('./FoldButton.elm');

var createFoldButtons = function (regexes) {
  var nodes = Array.prototype.slice.call(document.querySelectorAll('.file-actions'))

  nodes.forEach(function (node) {
    var path = node.parentNode.getAttribute('data-path')

    var foldOnInit = regexes.reduce(function (acc, regex) {
      return (acc = acc || !!path.match(RegExp(regex)))
    }, false)

    var codeBlob = node.parentNode.parentNode.querySelector('.blob-wrapper')

    if (codeBlob) {
      var foldButton = Elm.FoldButton.embed(node, foldOnInit)
      foldButton.ports.setDisplay.subscribe(function (value) {
        codeBlob.style.display = value
      })
    }
  })
}

chrome.storage.sync.get({ values: [] }, function (data) {
  document.addEventListener('pjax:success', createFoldButtons.bind(null, data.values), false)
  createFoldButtons(data.values)
})
