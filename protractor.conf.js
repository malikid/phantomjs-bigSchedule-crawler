require('coffee-script/register')

var baseUrl = 'http://' + (process.env.HTTP_IP || 'localhost') + ':' + (process.env.HTTP_PORT || '1337');
var seleniumAddress = 'http://' + (process.env.SELENIUM_IP || 'localhost') + ':' + (process.env.SELENIUM_PORT || '4444') + "/wd/hub";
var config = {
  // sauceUser: process.env.SAUCE_USERNAME,
  // sauceKey: process.env.SAUCE_ACCESS_KEY,
  framework: "mocha",
  // seleniumAddress: "http://localhost:4444/wd/hub",
  seleniumAddress: seleniumAddress,
  capabilities: {
    browserName: "chrome"
  },
  specs: [
    "testBigSchedules.coffee"
  ],
  baseUrl: "http://www.bigschedules.com",
  ignoreSynchronization: true
}

global.e2eConfig = config

exports.config = config
