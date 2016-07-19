require('file?name=./build/[name].[ext]!./manifest.json')
require('file?name=./build/[name].[ext]!./options.html')

var Elm = require('./fold_button.elm');

var createFoldButtons = function () {
  var nodes = Array.prototype.slice.call(document.querySelectorAll('.file-actions'))

  nodes.forEach(function (node) {
    var path = node.parentNode.getAttribute('data-path')
    var foldOnInit = path.match(/postcss\.css|bundle\.js/) && !path.match(/shared/)
    var codeBlob = node.parentNode.parentNode.querySelector('.blob-wrapper')

    if (codeBlob) {
      var foldButton = Elm.FoldButton.embed(node, !!foldOnInit)
      foldButton.ports.setDisplay.subscribe(function (value) {
        codeBlob.style.display = value
      })
    }
  })
}

document.addEventListener('pjax:success', createFoldButtons, false)
createFoldButtons()
