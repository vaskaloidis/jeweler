$(function(){
    var dataSource = [],
        max = 5000,
        i;
    
    for (i = 0; i < max; i++) {
        dataSource.push({ arg: i, val: i + i * (Math.random() - 0.5) });
    }
    
    var chart = $("#zoomedChart").dxChart({
        dataSource: dataSource,
        argumentAxis: {
            valueMarginsEnabled: false
        },
        valueAxis: {
            label:{
                format:{
                    type: "fixedPoint"
                }
            }
        },
        useAggregation: true,
        legend: {
            visible: false
        },
        series: {
            point: {
                size: 7
            }
        }
    }).dxChart("instance");
    
    $("#range-selector").dxRangeSelector({
        size: {
            height: 120
        },
        dataSource: dataSource,
        chart: {
            series: {},
            useAggregation: true
        },
        scale: {
            minRange: 1
        },
        sliderMarker: {
            format: {
                type: "decimal",
                precision: 0
            }
        },
        behavior: {
            callValueChanged: "onMoving",
            snapToTicks: false
        },
        onValueChanged: function (e) {
            chart.zoomArgument(e.value[0], e.value[1]);
        }
    });
});