var DemoApp = angular.module('DemoApp', ['dx']);

DemoApp.controller('DemoController', function DemoController($scope) {
    $scope.gridOptions = {
        dataSource: orders,
        columns: [{
            dataField: "OrderNumber",
            caption: "Invoice Number",
            width: 130
        },  {
            caption: "City",
            dataField: "CustomerStoreCity",
            hidingPriority: 0
        }, {
            caption: "State",
            dataField: "CustomerStoreState",
            hidingPriority: 1
        }, 
        "Employee",{
            dataField: "OrderDate",
            dataType: "date"
        }, {
            dataField: "SaleAmount",
            format: "currency"
        }]
    };
    
});