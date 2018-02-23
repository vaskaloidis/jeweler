var DemoApp = angular.module('DemoApp', ['dx']);

DemoApp.controller('DemoController', function DemoController($scope, $http, $q) {
   var orders = new DevExpress.data.CustomStore({
        load: function (loadOptions) {
            var parameters = {};           
    
            if (loadOptions.sort) {
                parameters.orderby = loadOptions.sort[0].selector;
                if (loadOptions.sort[0].desc)
                    parameters.orderby += " desc";
            }
            
            parameters.skip = loadOptions.skip || 0;
            parameters.take = loadOptions.take || 12;
            
            var config = {
                params: parameters
            };
            
            return $http.get("https://js.devexpress.com/Demos/WidgetsGallery/data/orderItems", config)
            .then(function (response) {
                return { data: response.data.items, totalCount: response.data.totalCount };
            }, function (response) {
                return $q.reject("Data Loading Error");
            });
        }
    });
    
    $scope.dataGridOptions = {
        dataSource: {
            store: orders
        },
        remoteOperations: {
            sorting: true,
            paging: true
        },
        paging: {
            pageSize: 12
        },
        pager: {
            showPageSizeSelector: true,
            allowedPageSizes: [8, 12, 20]
        },
        columns: [
            "OrderNumber", "OrderDate", "StoreCity", "StoreState", "Employee", {
                dataField: "SaleAmount",
                format: "currency"
            }
        ]
    };
});