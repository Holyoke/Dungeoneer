var path = require('path')
var webpack = require('webpack')
var gutil = require('gutil')

var watch_env = process.env['RAILS_ENV'] == 'production' ? false : true;

webpack({
  context: __dirname,
  entry: "./src/entry",
  resolve: {
    extensions: [".jsx", ".js", ""]
  },
  output: {
    path: path.join(__dirname, '..', 'app', 'assets', 'javascripts'),
    filename: "bundle.js"
  },
  watch: watch_env,
  module: {
    loaders: [
      {
        test: /\.jsx?$/,
        exclude: /(node_modules|bower_components)/,
        loader: 'babel',
        query: {
          presets: ['es2015', 'react']
        }
      }
    ]
  }
}, function(err, stats) {
  if(err) throw new gutil.PluginError("webpack", err);
  //Configures logging
  gutil.log("[webpack]", stats.toString({
  }));
});

