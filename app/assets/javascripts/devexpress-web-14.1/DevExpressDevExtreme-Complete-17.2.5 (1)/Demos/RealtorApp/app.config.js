"use strict";

window.RealtorApp = $.extend(true, window.RealtorApp, {
  "config": {
      "layoutSet": "navbar",
      "animationSet": "default",
    "commandMapping": {
      "generic-header-toolbar": {
        "defaults": {
          "showIcon": "true",
          "showText": "false",
          "location": "after"
        },
        "commands": [
          "list",
          "map",
          "gallery"
        ]
      }
    },
    "navigation": [
      {
        "title": "Search",
        "onExecute": "#Home",
        "icon": "home"
      },
      {
        "title": "Favorites",
        "onExecute": "#Favorites",
        "icon": "favorites"
      },
      {
        "title": "About",
        "onExecute": "#About",
        "icon": "info"
      }      
    ]
  }
});