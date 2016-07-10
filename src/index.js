'use strict';

var Elm = require('./fold_button.elm');

var nodes = Array.prototype.slice.call(document.querySelectorAll('.file-actions'))

nodes.forEach(function (node) {
  var foldOnInit = !!node.parentNode.getAttribute('data-path').match(/postcss\.css|bundle\.js/)
  var foldButton = Elm.FoldButton.embed(node, foldOnInit)

  foldButton.ports.fold.subscribe(function () {
    var code = node.parentNode.parentNode.querySelector('.blob-wrapper')
    code.style.display = 'none'
  })

  foldButton.ports.unfold.subscribe(function () {
    var code = node.parentNode.parentNode.querySelector('.blob-wrapper')
    code.style.display = 'block'
  })
})
