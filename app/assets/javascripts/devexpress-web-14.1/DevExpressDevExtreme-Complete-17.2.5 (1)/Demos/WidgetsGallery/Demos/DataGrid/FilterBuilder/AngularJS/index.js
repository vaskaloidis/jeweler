var DemoApp = angular.module('DemoApp', ['dx']);

DemoApp.controller('DemoController', function DemoController($scope) {
    var popup;

    $scope.dataGridFilter = filterValue;
    $scope.filterValue = filterValue;
    $scope.allowHierarchicalFields = false;
    $scope.clearButtonDisabled = false;
    $scope.filterButtonType = "success";
   
    $scope.gridOptions = {
        dataSource: {
            store: orders
        },        
        bindingOptions: {
            "dataSource.filter": "dataGridFilter"
        },
        columns: columns,
        onToolbarPreparing: function(e) {
            e.toolbarOptions.items.push({
                location: "before",
                widget: "dxButton",
                options: {
                    text: "Filter Builder",
                    bindingOptions: {
                        type: "filterButtonType",
                    },
                    icon: "filter",
                    onClick: function(e) {
                        popup.show(); 
                    }
                }
            }, {
                location: "before",
                widget: "dxButton",
                options: {
                    text: "Clear Filter",
                    bindingOptions: {
                        disabled: "clearButtonDisabled",
                    },
                    onClick: function(e) {
                        $scope.dataGridFilter = null;
                        $scope.filterValue = null;
                        $scope.clearButtonDisabled = true;
                        $scope.filterButtonType = "default";
                    }
                }
            });
        }
    };

    $scope.popupOptions = {
        title: "Filter Builder",
        deferRendering: false,
        contentTemplate: "popupContent",
        onInitialized: function(e) {
            popup = e.component;
        },
        onShowing: function() {
            $scope.filterValue = $scope.dataGridFilter;
        },
        toolbarItems: [
            {
                toolbar: "bottom", 
                location: "after", 
                widget: "dxButton", 
                options: {
                    text: "OK", 
                    onClick: function(e) {
                        var filter = $scope.filterValue;
                        $scope.dataGridFilter = filter;
                        $scope.filterButtonType = filter ? "success" : "default";
                        $scope.clearButtonDisabled = !filter;
                        popup.hide();
                    }
                }
            },
            {
                toolbar: "bottom", 
                location: "after", 
                widget: "dxButton", 
                options: {
                    text: "Cancel", 
                    onClick: function(e) {
                        popup.hide();
                    }
                }
            }
        ]
    };

    $scope.filterBuilderOptions = {
        bindingOptions: {
            value: "filterValue",
            allowHierarchicalFields: "allowHierarchicalFields"
        },
        fields: columns,
    };

    $scope.scrollViewOptions = {
        direction: 'both'
    };

    $scope.allowHierarchicalFieldsOptions = {
        text: "Allow hierarchical fields",
        bindingOptions: {
            value: "allowHierarchicalFields"
        }
    };
});