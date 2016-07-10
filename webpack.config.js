var path = require("path");

module.exports = {
  entry: {
    app: [ './src/index.js' ]
  },

  output: {
    filename: './build/github_fold.js',
  },

  module: {
    loaders: [
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:  'elm-webpack',
      },
    ],

    noParse: /\.elm$/,
  },

  devServer: {
    inline: true,
    stats: { colors: true },
  },

};
