window.onload = function() {
    var viewModel = {
        chartOptions: {
            palette: "soft",
            equalBarWidth: false,
            dataSource: dataSource,
            commonSeriesSettings: {
                argumentField: "state",
                type: "bar"
            },
            series: [
                { valueField: "oil", name: "Oil Production" },
                { valueField: "gas", name: "Gas Production" },
                { valueField: "coal", name: "Coal Production" }
            ],
            legend: {
                verticalAlignment: "bottom",
                horizontalAlignment: "center"
            },
            "export": {
                enabled: true
            },
            title: "Percent of Total Energy Production"
        }
    };
    
    ko.applyBindings(viewModel, document.getElementById("chart-demo"));
};