module.exports = {
  plugins: {
    'postcss-smart-import': {
      addDependencyTo: require('webpack')
    },
    'postcss-url': {
      url: "rebase",
    },
    'postcss-css-variables': {},
    'postcss-nested': {},
    'postcss-preset-env': {
      stage: 3,
    },
    autoprefixer: {},
  },
};
