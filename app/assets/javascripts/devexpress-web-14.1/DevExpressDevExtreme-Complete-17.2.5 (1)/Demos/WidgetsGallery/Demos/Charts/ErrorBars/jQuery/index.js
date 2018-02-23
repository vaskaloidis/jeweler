$(function(){
    $("#chart").dxChart({
        dataSource: dataSource,
        commonSeriesSettings: {
            argumentField: "month",
        },
        panes: [{
            name: "top"
        }, {
            name: "bottom"
        }],
        defaultPane: "bottom",
        series:[{ 
            pane: "top",
            valueField: "avgT",
            name: "Average Temperature, °C",
            valueErrorBar: {
                lowValueField: "avgLowT",
                highValueField: "avgHighT",
                lineWidth: 1,
                opacity: 0.8
            }
        }, {
            pane: "bottom",
            valueField: "avgH",
            type: "bar",
            name: "Average Humidity, %",
            valueErrorBar: {
                type: "fixed",
                value: 3,
                lineWidth: 1
            }
        }],   
        argumentAxis: {
            label: {
                displayMode: "stagger"
            }
    	},
    	"export": {
    	    enabled: true
    	},
        valueAxis: [{
            min: 0,
            max: 30,
            pane: "top",
            grid: {
                visible: true
            },
            title: {
                text: "Temperature, °C"
            }
        }, {
            min: 0,
            tickInterval: 50,
            pane: "bottom",
            grid: {
                visible: true
            },
            title: {
                text: "Humidity, %"
            }
        }],
        tooltip: {
            enabled: true,
            customizeTooltip: function (arg) {
                return {
                    text: arg.seriesName + ": " + arg.value + " ( range: " + arg.lowErrorValue  + " - "  + arg.highErrorValue + ")"
                };
            }
        },
        legend: {
            verticalAlignment: "bottom",
            horizontalAlignment: "center"
        },
        title: {
            text: "Weather in Los Angeles, California"
        }
    });
});