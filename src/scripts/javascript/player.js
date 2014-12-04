"use strict";
var app = Ember.Application.create();

app.Router.map(function shows(){
  var self = this;

  self.resource("shows", { path: "/" });
});

//TODO Figure out why this error occurs Uncaught TypeError: Attempting to register an unknown factory: `store:main`
