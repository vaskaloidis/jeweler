'use strict';

/* Controllers */

angular.module('demoApp.controllers', [])
    .controller('SlideOutCtrl', ['$scope', '$location', 'navigationItems', 'currentViewInfo', 'menu', function($scope, $location, navigationItems, currentViewInfo, menu) {
        var that = this;

        that.navigationItems = navigationItems;

        that.itemSelected = function(e) {			
            menu.setVisibility(false);
            $location.path(e.addedItems[0].uri);
        };

        that.itemClick = function() {
            menu.setVisibility(false);
        };

        $scope.$watch(currentViewInfo.getSelectedIndex, function(selectedIndex) {
            that.selectedIndex = selectedIndex;
        });

        $scope.$watch(menu.getVisibility, function(menuVisible) {
            that.menuVisible = menuVisible;
        });
        $scope.$watch(function() {
            return that.menuVisible;
        }, function(menuVisible) {
            menu.setVisibility(menuVisible);
        });
    }])
    .controller('ToolbarCtrl', ['$scope', 'currentViewInfo', 'menu', function($scope, currentViewInfo, menu) {
        var that = this;

        that.title = currentViewInfo.getTitle();
        $scope.$watch(currentViewInfo.getTitle, function(title) {
            that.title = title;
        });

        that.toggleMenu = menu.toggle;
    }])
    .controller('HomeCtrl', function() {
    })
    .controller('AboutCtrl', function() {
    });