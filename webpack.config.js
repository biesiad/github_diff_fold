module.exports = {
  entry: { github_fold: './src/index.js' },
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
