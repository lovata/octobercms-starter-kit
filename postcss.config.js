module.exports = {
    plugins: {
        'postcss-css-variables': {},
        'postcss-smart-import': {
            addDependencyTo: require('webpack')
        },
        'postcss-url': {
            url: "rebase"
        },
        'postcss-nested': {},
        'autoprefixer': {}
    }
};
