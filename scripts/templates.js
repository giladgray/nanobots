this["Templates"] = this["Templates"] || {};

this["Templates"]["landing"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "<div class=\"jumbotron\">\n	<h1>Welcome to nanobots</h1>\n    <h3>All Backstrapped and ready to go!</h3>\n    <br>\n    <div class=\"well text-center\">\n        <ul class=\"list-inline\">\n            <li><a href=\"http://backbonejs.org\">Backbone</a></li>\n            <li><a href=\"http://layoutmanager.org\">LayoutManager</a></li>\n            <li><a href=\"https://github.com/backbone-boilerplate/backbone-boilerplate\">Boilerplate</a></li>\n            <li><a href=\"http://getbootstrap.com\">Bootstrap 3.0</a></li>\n            <li><a href=\"http://handlebarsjs.com\">Handlebars</a></li>\n            <li><a href=\"http://coffeescript.org\">CoffeeScript</a></li>\n            <li><a href=\"http://browserify.org\">Browserify</a></li>\n            <li><a href=\"http://gruntjs.com/\">Grunt</a></li>\n        </ul>\n        <button class=\"btn btn-success btn-lg\">You're going to have a great time.</button>\n    </div>\n</div>\n<a href=\"\"></a>\n";
  });

this["Templates"]["layouts/layout"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "<div id=\"navbar\"></div>\n<div id=\"content\"></div>\n";
  });

this["Templates"]["navbar"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "<nav class=\"navbar navbar-default\" role=\"navigation\">\n    <!-- Brand and toggle get grouped for better mobile display -->\n    <div class=\"navbar-header\">\n        <button type=\"button\" class=\"navbar-toggle\" data-toggle=\"collapse\" data-target=\".navbar-collapse\">\n            <span class=\"sr-only\">Toggle navigation</span>\n            <span class=\"icon-bar\"></span>\n            <span class=\"icon-bar\"></span>\n            <span class=\"icon-bar\"></span>\n        </button>\n        <a href=\"#\" class=\"navbar-brand\">nanobots</a>\n    </div>\n\n    <!-- Collect the nav links, forms, and other content for toggling -->\n    <div class=\"collapse navbar-collapse\">\n        <p class=\"navbar-text\">\n            The most awesome webapp ever built.\n        </p>\n        <ul class=\"nav navbar-nav navbar-right\">\n            <li><a href=\"#about\">About</a></li>\n            <li><a href=\"#login\">Login</a></li>\n            <li><a href=\"https://github.com/giladgray/generator-backstrap\" target=\"_blank\">GitHub</a></li>\n        </ul>\n    </div>\n</nav>\n";
  });