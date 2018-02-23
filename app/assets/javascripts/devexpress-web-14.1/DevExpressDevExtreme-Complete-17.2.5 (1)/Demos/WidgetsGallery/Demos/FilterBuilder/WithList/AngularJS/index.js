var DemoApp = angular.module('DemoApp', ['dx']);

DemoApp.controller('DemoController', function DemoController($scope) {
    $scope.filterBuilderValue = filter;
    $scope.listFilter = filter;

    $scope.filterBuilderOptions = {
        fields: fields,
        bindingOptions: {
            value: "filterBuilderValue"
        }
    };

    $scope.scrollViewOptions = {
        direction: 'both'
    };

    $scope.buttonOptions = {
        text: "Apply Filter",
        type: "default",
        onClick: function() {
            $scope.listFilter = $scope.filterBuilderValue;
        },
    };

    $scope.listOptions = {
        dataSource: {
            store: products
        },
        height: "100%",
        bindingOptions: {
            "dataSource.filter": "listFilter"
        }
    };

});