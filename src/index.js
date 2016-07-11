'use strict';

var Elm = require('./fold_button.elm');

var createFoldButtons = function () {
  var nodes = Array.prototype.slice.call(document.querySelectorAll('.file-actions'))

  nodes.forEach(function (node) {
    var foldOnInit = !!node.parentNode.getAttribute('data-path').match(/postcss\.css|bundle\.js/)
    var foldButton = Elm.FoldButton.embed(node, foldOnInit)

    var display = function (value) {
      var codeNode = this.parentNode.parentNode.querySelector('.blob-wrapper')
      codeNode.style.display = value
    }

    foldButton.ports.setDisplay.subscribe(display.bind(node))
  })
}

document.addEventListener('pjax:success', createFoldButtons, false)
createFoldButtons()
