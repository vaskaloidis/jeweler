$(function() {
    $("#gridContainer").dxDataGrid({
        dataSource: weekData,
        showRowLines: true,
        showBorders: true,
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
        columns: [{
                dataField: "date",
                dataType: "date",
                width: 90
            },
            "open",
            "close",
            {
                caption: "Dynamics",
                width: 155,
                cellTemplate: function(container, options) {
                    container.addClass("chart-cell");
                    $("<div />").dxSparkline({
                        dataSource: options.data.dayClose,
                        argumentField: "date",
                        valueField: "close",
                        type: "line",
                        showMinMax: true,
                        minColor: "#f00",
                        maxColor: "#2ab71b",
                        pointSize: 6,
                        size: {
                            width: 140,
                            height: 30
                        },
                        tooltip: {
                            enabled: false
                        }
                    }).appendTo(container);
                }
            },
            "high",
            "low"
        ]
    });

});