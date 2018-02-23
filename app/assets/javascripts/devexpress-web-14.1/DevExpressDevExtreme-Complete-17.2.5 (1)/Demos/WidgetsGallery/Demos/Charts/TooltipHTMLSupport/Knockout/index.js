window.onload = function() {
    var viewModel = {
        pieChartOptions: {
            palette: "bright",
            dataSource: states,
            title: "Top 10 Most Populated States in US",
            series: {
                argumentField: "name",
                valueField: "population",
                tagField: "data"
            },
            "export": {
                enabled: true
            },
            tooltip: {
                enabled: true,
                customizeTooltip: function (args) {
                    return {
                        html: "<div class='state-tooltip'><img src='../../../../images/flags/" + 
                        args.point.tag.flag + ".gif' /><h4>" +
                        args.argument + "</h4><div><b>Capital</b>: " +
                        args.point.tag.capital +
                        "</div><div><b>Population</b>: " +
                        Globalize.formatNumber(args.value, { maximumFractionDigits: 0 }) +
                        " people</div>" + "<div><b>Area</b>: " +
                        Globalize.formatNumber(args.point.tag.area, { maximumFractionDigits: 0 }) +
                        " km<sup>2</sup> (" +
                        Globalize.formatNumber(0.3861 * args.point.tag.area, { maximumFractionDigits: 0 }) +
                        " mi<sup>2</sup>)" + "</div>" + "</div>"
                    };
                }
            }
        }
    };
    
    ko.applyBindings(viewModel, document.getElementById("chart-demo"));
};