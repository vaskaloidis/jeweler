var DemoApp = angular.module('DemoApp', ['dx']);

DemoApp.controller('DemoController', function DemoController($scope) {
    $scope.dataGridOptions = {
        dataSource: weekData,
        showRowLines: true,
        sorting: {
            mode: "none"
        },
        paging: {
            pageSize: 10
        },
        onCellPrepared: function(options) {
            var fieldData = options.value,
                fieldHtml = "";
            if(fieldData && fieldData.value) {
                if(fieldData.diff) {
                    options.cellElement.addClass((fieldData.diff > 0) ? "inc" : "dec");
                    fieldHtml += "<span class='current-value'>" +
                        Globalize.formatCurrency(fieldData.value, "USD") +
                        "</span> <span class='diff'>" +
                        Math.abs(fieldData.diff).toFixed(2) +
                        "  </span>";
                } else {
                    fieldHtml = fieldData.value;
                }
                options.cellElement.html(fieldHtml);
            }
        },
        columns: [
            {
                dataField: "date",
                dataType: "date",
                width: 90
            },
            "open",
            "close",
            {
                caption: "Dynamics",
                width: 155,
                cellTemplate: "cellTemplate"
            },
            "high",
            "low"
        ]
    };
});