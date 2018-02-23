'use strict';

/* Services */

angular.module('demoApp.services', [])
    .value('device', DevExpress.devices.current())
    .value('navigationItems', [
        {
            title: 'Home',
            text: 'Home',
            uri: '/home',
            icon: 'home'
        },
        {
            title: 'About',
            text: 'About',
            uri: '/about',
            icon: 'info'
        }
    ])
    .factory('currentViewInfo', ['$rootScope', 'navigationItems', function($rootScope, navigationItems) {
        var selectedIndex,
            viewTitle;

        $rootScope.$on('$routeChangeStart', function(event, nextLoc, currentLoc) {
            if(nextLoc.$$route) {
                if(DevExpress.hideTopOverlay()) {
                    event.preventDefault();
                }
                else {
                    selectedIndex = $.inArray(nextLoc.$$route.originalPath, $.map(navigationItems, function(item) {
                        return item.uri;
                    }));
                    if(selectedIndex > -1) {
                        viewTitle = navigationItems[selectedIndex].title;
                    } else {
                        viewTitle = undefined;
                    }
                }
            }
        });

        return {
            getSelectedIndex: function() {
                return selectedIndex;
            },
            getTitle: function() {
                return viewTitle;
            }
        }
    }]);