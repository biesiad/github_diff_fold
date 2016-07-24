module.exports = {
  entry: {
    content_scripts: './src/content_scripts.js',
    options: './src/options.js'
  },
  output: { filename: './build/[name].js', },
  module: {
    loaders: [
      { test: /\.elm$/, exclude: [/elm-stuff/, /node_modules/], loader:  'elm-webpack', }
    ],
    noParse: /\.elm$/,
  },
  devServer: {
    inline: true,
    stats: { colors: true }
  }
}
