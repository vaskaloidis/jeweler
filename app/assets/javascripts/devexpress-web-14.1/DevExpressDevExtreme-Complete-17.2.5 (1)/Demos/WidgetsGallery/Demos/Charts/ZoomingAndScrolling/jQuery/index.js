$(function(){
    
    var zoomedChart = $("#chart").dxChart({
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
        }
    }).dxChart("instance");
    
    zoomedChart.zoomArgument(300, 500);
});