var DemoApp = angular.module('DemoApp', ['dx']);

DemoApp.controller('DemoController', function DemoController($scope) {
    $scope.currentColor = "#f05b41";
    $scope.colorBox = {
        simple: {
            value: "#f05b41"
        },
        disabled: {
            value: "#f05b41",
            disabled: true
        },
        readOnly: {
            value: "#f05b41",
            readOnly: true
        },
        editButtonText: {
            value: "#f05b41",
            applyButtonText: "Apply",
            cancelButtonText: "Decline"
        },
        editAlphaChannel: {
            value: "#f05b41",
            editAlphaChannel: true
        },
        withChangeValue: {        
            applyValueMode: "instantly",
            bindingOptions: {
                value: "currentColor"
            }
        }
    };
    
});