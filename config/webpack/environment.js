const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')
const webpack = require('webpack')
const dotenv = require('dotenv');

const dotenvFiles = [
  `.env.${process.env.NODE_ENV}.local`,
  '.env.local',
  `.env.${process.env.NODE_ENV}`,
  '.env'
]

dotenvFiles.forEach((dotenvFile) => {
  dotenv.config({ path: dotenvFile, silent: true })
})

environment.plugins.append('Environment', new webpack.EnvironmentPlugin(JSON.parse(JSON.stringify(process.env))))

environment.loaders.append('vue', vue)
module.exports = environment
