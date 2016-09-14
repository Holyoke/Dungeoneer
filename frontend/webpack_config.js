//Build and bundle js responsible for concat and bundling react to js
// builtin node library for requiring paths
var path = require('path')
var webpack = require('webpack')
// logging
var gutil = require('gutil')

// var watch_env = process.env['test']
webpack({
  //defines the root path
  context: __dirname,
  entry: "./src/index",
  //this tells webpack what the default extensions are
  resolve: {
    extensions: [".jsx", ".js", ""]
  },
  output: {
    path: path.join(__dirname, '..', 'app', 'assets', 'javascripts'),
    filename: "bundle.js"
  },
  //production this set to false conditionally
  watch: true,
  module: {
    loaders: [
      {
        test: /\.jsx?$/,
        //parses js and jsx ? means last char is optional
        exclude: /(node_modules|bower_components)/,
        loader: 'babel', // 'babel-loader' is also a legal name to reference
        query: {
          // the type of syntax that webpack understands
          presets: ['es2015', 'react']
        }
      }
    ]
  }
}, function(err, stats) {
  if(err) throw new gutil.PluginError("webpack", err);
  //logging
  gutil.log("[webpack]", stats.toString({
    // output options
  }));
});

