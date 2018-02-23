'use strict';

/* Controllers */

angular.module('demoApp.controllers', [])
    .controller('LayoutCtrl', ['$scope', '$location', 'navigationItems', 'device', 'currentViewInfo', function($scope, $location, navigationItems, device, currentViewInfo) {
        var that = this;

        if(device.platform === 'win8') {
            that.includePath = 'partials/pivotLayout.html'
        } else {
            that.includePath = 'partials/navbarLayout.html'
        }
        
        that.navigationItems = navigationItems;

        that.hasToolbar = false;

        currentViewInfo.setHasToolbar = function(hasToolbar) {
            that.hasToolbar = hasToolbar;
        };

        $scope.$watch(currentViewInfo.getSelectedIndex, function(selectedIndex) {
            that.selectedIndex = selectedIndex;
        });

        that.navigationItemSelected = function(e) {
            $location.path(e.addedItems[0].uri);
        };
    }])
    .controller('ToolbarCtrl', ['$scope', 'currentViewInfo', 'device', function($scope, currentViewInfo, device) {
        var that = this,
            topToolbar = device.platform === 'ios' || device.platform === 'generic';

        that.items = [];
        
        if(topToolbar) {
            that.items.push({
                location: 'center'
            });

            that.title = currentViewInfo.getTitle();
            $scope.$watch(currentViewInfo.getTitle, function(title) {
                that.title = title;
            });

            var itemIndex = that.items.length - 1,
                optionPath = 'items[' + itemIndex + '].text';
            
            that.bindingOptions = {};
            that.bindingOptions[optionPath] = 'toolbar.title';
        }

        that.renderAs = topToolbar ? 'topToolbar' : 'bottomToolbar';

        currentViewInfo.setHasToolbar(!!that.items.length);
    }])
    .controller('HomeCtrl', function() {
    })
    .controller('AboutCtrl', function() {
    });