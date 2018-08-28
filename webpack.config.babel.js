import path from 'path';
import webpack from 'webpack';
// import CopyWebpackPlugin from 'copy-webpack-plugin';
// import ImageminPlugin from 'imagemin-webpack-plugin';
// import imageminMozjpeg from 'imagemin-mozjpeg';
import MiniCssExtractPlugin from 'mini-css-extract-plugin';
import CleanWebpackPlugin from 'clean-webpack-plugin';
import StyleLintPlugin from 'stylelint-webpack-plugin';
import CssoWebpackPlugin from 'csso-webpack-plugin';
import UglifyJSPlugin from 'uglifyjs-webpack-plugin';

const NODE_ENV = process.env.NODE_ENV || 'production';
const WATCH = process.env.WATCH || false;

const prefix = NODE_ENV === 'production' ? 'prod_' : 'dev_';

const config = {
  mode: NODE_ENV,
  entry: {
    [`${prefix}main`]: path.resolve('themes/THEME_NAME/common.js'),
  },
  output: {
    path: path.resolve('themes/THEME_NAME/assets'),
    publicPath: '/assets/',
    filename: 'js/[name].js',
    chunkFilename: 'js/[id].chunk.js',
    library: '[name]',
  },
  watch: WATCH === 'watch',
  devtool: NODE_ENV === 'development' ? 'source-map' : false,
  resolve: {
    modules: ['node_modules'],
    extensions: ['.js', '.jsx'],
  },
  context: path.resolve(),
  plugins: [
    new webpack.NoEmitOnErrorsPlugin(),
    new webpack.optimize.ModuleConcatenationPlugin(),
    // new CopyWebpackPlugin([{
    //   from: 'themes/THEME_NAME/src/img/',
    //   to: 'img/',
    // }]),
    // new ImageminPlugin({
    //   test: /\.(jpe?g|png|svg)$/i,
    //   plugins: [
    //     imageminMozjpeg({
    //       quality: 60,
    //       progressive: true,
    //     }),
    //   ],
    // }),
    new MiniCssExtractPlugin({
      filename: 'css/[name].css',
      chunkFilename: '[id].css',
    }),
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: JSON.stringify(NODE_ENV),
      },
    }),
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      'window.jQuery': 'jquery',
    }),
    new CleanWebpackPlugin([
      path.resolve('themes/THEME_NAME/assets/css'),
      path.resolve('themes/THEME_NAME/assets/js'),
    ], {
      root: '',
      verbose: true,
      dry: false,
    }),
    new StyleLintPlugin({
      files: ['themes/THEME_NAME/*.css', 'themes/THEME_NAME/styles/**/*.css'],
      failOnError: true,
    }),
  ],
  module: {
    rules: [{
      enforce: 'pre',
      test: /\.js$/,
      exclude: /node_modules/,
      loader: 'eslint-loader',
      options: {
        fix: true,
      },
    },
    {
      test: /\.js$/,
      exclude: /node_modules/,
      use: [
        'babel-loader',
      ],
    },
    {
      test: /\.css$/,
      exclude: [
        path.resolve('src/components'),
      ],
      use: [
        {
          loader: MiniCssExtractPlugin.loader,
        },
        {
          loader: 'css-loader',
          options: {
            sourceMap: NODE_ENV === 'development',
          },
        },
        {
          loader: 'postcss-loader',
          options: {
            sourceMap: NODE_ENV === 'development',
          },
        },
      ],
    },
    {
      test: /\.(gif|png|jpe?g|svg)$/,
      use: [
        'file-loader?name=img/[name].[ext]',
        {
          loader: 'image-webpack-loader',
          options: {
            mozjpeg: {
              quality: 65,
            },
            optipng: {
              enabled: false,
            },
            pngquant: {
              quality: '65-90',
              speed: 4,
            },
            gifsicle: {
              interlaced: false,
            },
            // webp: {
            //   quality: 75,
            // },
          },
        },
      ],
    },
    ],
  },
};

if (NODE_ENV === 'production') {
  config.plugins.push(new CssoWebpackPlugin());
  config.plugins.push(new UglifyJSPlugin());
}

export default config;
