require.config({
  paths: {
    cs: 'lib/cs',
    order: 'lib/order',
    text: 'lib/text',
    jquery: 'lib/jquery-1.7.2.min',
    underscore: 'lib/underscore-min',
    backbone: 'lib/backbone-wraper',
    mustache: 'lib/mustache'
  }
});
require([
  'order!jquery',
  'cs!app',
  'order!lib/jquery.couch',
  'backbone'
], function($, App) {
  window.app = new App({el: $('#stage')});
});
