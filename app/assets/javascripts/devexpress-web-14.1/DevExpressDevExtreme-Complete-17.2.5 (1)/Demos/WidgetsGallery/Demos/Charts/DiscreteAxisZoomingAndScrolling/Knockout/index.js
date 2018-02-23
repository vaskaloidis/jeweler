window.onload = function() {
    var viewModel = {
        chartOptions: {
            palette: "soft",
            equalBarWidth: false,
            title:"The Chemical Composition of the Earth Layers",
            valueAxis: {
                label:{
                    customizeText: function() {
                        return this.valueText + "%"; 
                    }
                }
            },
            dataSource: dataSource,
            series: series,
            commonSeriesSettings: {
                type: "bar"
            },
            legend: {
                border: {
                    visible: true
                },
                visible: true,
                verticalAlignment: "top",
                horizontalAlignment: "right",
                orientation:"horizontal"
            }
        },
        rangeOptions: {
            size: {
                height: 120
            },
            margin: {
                left: 10
            },
            scale: {
                minorTickCount: 1
            },
            dataSource: dataSource,
            chart: {
                palette: "soft",
                commonSeriesSettings: {
                    type: "bar"
                },
                equalBarWidth: false,
                series: series
            },
            behavior: {
                callValueChanged: "onMoving"
            },
            onValueChanged: function (e) {
                var zoomedChart = $("#chart-demo #zoomedChart").dxChart("instance");
                zoomedChart.zoomArgument(e.value[0], e.value[1]);
            }
        }
    };
    
    ko.applyBindings(viewModel, document.getElementById("chart-demo"));
};