var DemoApp = angular.module('DemoApp', ['dx']);

DemoApp.controller('DemoController', function DemoController($scope) {
    $scope.chartOptions = {
        palette: "Harmony Light",
        dataSource: zoomingData,
        series: [{
            argumentField: "arg",
            valueField: "y1"
        }, {
            argumentField: "arg",
            valueField: "y2"
        }],
        scrollBar: {
            visible: true
        },
        scrollingMode: "all", 
        zoomingMode: "all",
        legend:{
            visible: false
        },
        onInitialized: function(e) {
            e.component.zoomArgument(300,500);
        }
    };
});