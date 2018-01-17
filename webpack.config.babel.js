const NODE_ENV = process.env.NODE_ENV || 'production';
const WATCH = process.env.WATCH || false;

const prefix = NODE_ENV === 'production' ? 'prod_' : 'dev_';

import webpack from 'webpack';
import path from 'path';
import ExtractTextPlugin from 'extract-text-webpack-plugin';
const extractTextCSS = new ExtractTextPlugin({ filename: `css/${prefix}common.css`, allChunks: true });
import CleanWebpackPlugin from 'clean-webpack-plugin';
import StyleLintPlugin from 'stylelint-webpack-plugin';
import StyleExtHtmlWebpackPlugin from 'style-ext-html-webpack-plugin';
import CssoWebpackPlugin from 'csso-webpack-plugin';
import UglifyJSPlugin from 'uglifyjs-webpack-plugin';

let config = {
    entry: {
        [prefix + 'main']: path.resolve('themes/THEME_NAME/main.js')
    },
    output: {
        path: path.resolve('themes/THEME_NAME/assets'),
        publicPath: "/assets/",
        filename: 'js/[name].js',
        chunkFilename: 'js/[id].chunk.js',
        library: '[name]'
    },
    watch: WATCH === 'watch',
    devtool: NODE_ENV === 'development' ? 'source-map' : false,
    resolve: {
        modules: ['node_modules'],
        extensions: ['.js', '.jsx']
    },
    context: path.resolve(),
    plugins: [
        new webpack.NoEmitOnErrorsPlugin(),
        new webpack.optimize.ModuleConcatenationPlugin(),
        new webpack.DefinePlugin({
            'process.env': {
                'NODE_ENV': JSON.stringify(NODE_ENV)
            }
        }),
        new webpack.ProvidePlugin({
            $: 'jquery',
            jQuery: 'jquery',
            'window.jQuery': 'jquery'
        }),
        new CleanWebpackPlugin([
            path.resolve('themes/THEME_NAME/assets/css'),
            path.resolve('themes/THEME_NAME/assets/js')
        ], {
            root: '',
            verbose: true,
            dry: false
        }),
        extractTextCSS,
        new StyleLintPlugin({
            files: ['themes/THEME_NAME/*.css', 'themes/THEME_NAME/styles/**/*.css']
        })
    ],
    module: {
        rules: [
            {
                enforce: "pre",
                test: /\.js$/,
                exclude: /node_modules/,
                loader: "eslint-loader",
                options: {
                    fix: true,
                    formatter: require("eslint/lib/formatters/stylish"),
                }
            },
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: [
                    'babel-loader'
                ]
            },
            {
                test: /\.css$/,
                exclude: [
                    path.resolve('src/components')
                ],
                loader: extractTextCSS.extract({
                    fallback: 'style-loader',
                    use: [
                        {
                            loader: 'css-loader', options: { sourceMap: NODE_ENV === 'development' }
                        },
                        {
                            loader: 'postcss-loader', options: { sourceMap: NODE_ENV === 'development' }
                        }
                    ]
                })
            }
        ]
    }
};

if(NODE_ENV === 'production') {
    config.plugins.push(
        new StyleExtHtmlWebpackPlugin()
    );

    config.plugins.push(
        new CssoWebpackPlugin()
    );

    config.plugins.push(
        new UglifyJSPlugin()
    );
}

export default config;
