var DemoApp = angular.module('DemoApp', ['dx']);

DemoApp.controller('DemoController', function DemoController($scope) {
    $scope.gridOptions = {
        dataSource: employees,
        keyExpr: "ID",
        columns: [{
                dataField: "Prefix",
                caption: "Title",
                width: 70
            },
            "FirstName",
            "LastName", {
                dataField: "Position",
                width: 170
            }, {
                dataField: "State",
                width: 125
            }, {
                dataField: "BirthDate",
                dataType: "date"
            }
        ],
        masterDetail: {
            enabled: true,
            template: "detail"
        }
    };
    
    $scope.completedValue = function(rowData) {
        return rowData.Status == "Completed";
    };
    
});