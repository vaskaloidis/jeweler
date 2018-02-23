var DemoApp = angular.module('DemoApp', ['dx']);

DemoApp.controller('DemoController', function DemoController($scope) {
    var employeesStore = new DevExpress.data.ArrayStore(employees);
        
    $scope.selectedItems = [];
    $scope.disabled = true;
    
    $scope.buttonOptions = {
        text: "Delete Selected Records",
        height: 34,
        width: 195,
        onClick: function () {
            $.each($scope.selectedItems, function() {
                employeesStore.remove(this);
            });
            $("#gridContainer").dxDataGrid("instance").refresh();
        },
        bindingOptions: {
            disabled: "disabled"
        }
    };
    
    $scope.dataGridOptions = {
       dataSource: employeesStore,
       keyExpr: "ID",
        paging: {
            enabled: false
        },
        editing: {
            mode: "cell",
            allowUpdating: true
        },
        selection: {
            mode: "multiple"
        },
        onSelectionChanged: function(data) {
            $scope.selectedItems = data.selectedRowsData;
            $scope.disabled = !$scope.selectedItems.length;
        }, 
        columns: [
            {
                dataField: "Prefix",
                caption: "Title",
                width: 55
            },
            "FirstName",
            "LastName", {
                dataField: "Position",
                width: 170
            }, {
                dataField: "StateID",
                caption: "State",
                width: 125,
                lookup: {
                    dataSource: states,
                    displayExpr: "Name",
                    valueExpr: "ID"
                }
            }, {
                dataField: "BirthDate",
                dataType: "date"
            }
        ]
    };
    
});