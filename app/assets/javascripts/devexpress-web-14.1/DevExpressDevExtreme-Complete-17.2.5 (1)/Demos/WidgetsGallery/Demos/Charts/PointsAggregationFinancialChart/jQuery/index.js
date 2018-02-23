$(function(){
    var chart = $("#zoomedChart").dxChart({
        title: "Google Inc. Stock Prices",
        dataSource: dataSource,
        commonSeriesSettings: {
            type: "candleStick"
        },
        valueAxis: {
            valueType: "numeric"
        },
        argumentAxis: {
            valueMarginsEnabled: false,
            grid: {
                visible: true
            },
            label: {
                visible: false
            },
            argumentType: "datetime"
        },
        tooltip: {
            enabled: true
        },
        legend: {
            visible: false
        },
        useAggregation: true,
        series: [{
            openValueField: "Open",
            highValueField: "High",
            lowValueField: "Low",
            closeValueField: "Close",
            argumentField: "Date"
        }]
    }).dxChart("instance");
    
    $("#range-selector").dxRangeSelector({
        size: {
            height: 120
        },
        dataSource: dataSource,
        chart: {
            useAggregation: true,
            valueAxis: { valueType: "numeric" },
            series: {
                type: "line",
                valueField: "Open",
                argumentField: "Date"
            }
        },
        scale: {
            minorTickInterval: "day",
            tickInterval: "month",
            valueType: "datetime",
            placeholderHeight: 20
        },
        behavior: {
            callValueChanged: "onMoving",
            snapToTicks: false
        },
        onValueChanged: function (e) {
            chart.zoomArgument(new Date(e.value[0]), new Date(e.value[1]));
        }
    });
});