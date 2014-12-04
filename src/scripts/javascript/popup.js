"use strict";
/* Setup */
window.App = Ember.Application.create();

App.ApplicationAdapter = DS.FixtureAdapter;

/* Models */
App.Show = DS.Model.extend({
  name: DS.attr(),
  description: DS.attr(),
  episodes: DS.attr()
});

App.Show.FIXTURES = [
  {
    id: 1,
    name: "Idle Thumbs",
    description: "A weekly video game podcast full of in-depth discussion and absurdity. Hosted by Chris Remo, Jake Rodkin, Danielle Riendeau, Sean Vanaman, and Nick Breckon.",
    episodes: []
  },
  {
    id: 2,
    name: "Three Moves Ahead",
    description: "Three Moves Ahead is the leading strategy game themed podcast on the internet.",
    episodes: []
  }
];

App.Episode = DS.Model.extend({
  title: DS.attr(),
  description: DS.attr(),
  publishDate: DS.attr(),
  mediaFile: DS.attr()
});

/* Routes */
App.Router.map(function shows(){
  var self = this;

  self.route("shows", { path: "/" });
  self.route("show", { path: "/show_name" });
});

App.ShowsRoute = Ember.Route.extend({
  model: function ShowsRoute(){
    var self = this;

    return self.store.find("show");
  }
});
