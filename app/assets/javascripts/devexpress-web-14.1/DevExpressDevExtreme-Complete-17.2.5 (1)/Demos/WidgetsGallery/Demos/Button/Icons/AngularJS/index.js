var DemoApp = angular.module('DemoApp', ['dx']);

DemoApp.controller('DemoController', function DemoController($scope) {    
    $scope.doneButton = {
        icon: "check",
        type: "success",
        text: "Done",
        onClick: function(e) { 
            DevExpress.ui.notify("The Done button was clicked");
        }
    };

    $scope.weatherButton = {
        icon: "../../../../images/icons/weather.png",
        text: "Weather",
        onClick: function(e) { 
            DevExpress.ui.notify("The Weather button was clicked");
        }
    };

    $scope.sendButton = {
        icon: 'fa fa-envelope-o',
        text: "Send",
        onClick: function(e) { 
            DevExpress.ui.notify("The Send button was clicked");
        }
    };

    $scope.plusButton = {
        icon: "plus",
        onClick: function(e) { 
            DevExpress.ui.notify("The button was clicked");
        }
    };
                
});