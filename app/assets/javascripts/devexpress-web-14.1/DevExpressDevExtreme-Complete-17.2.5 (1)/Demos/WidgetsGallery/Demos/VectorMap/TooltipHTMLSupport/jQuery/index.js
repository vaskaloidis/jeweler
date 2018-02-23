$(function(){
    function format(data) {
        return Globalize.formatNumber(data, { maximumfractiondigits: 0 });
    }
    
    $("#vector-map").dxVectorMap({
        layers: {
            name: "areas",
            dataSource: DevExpress.viz.map.sources.world,
            palette: "violet",
            colorGroups: [0, 10000, 50000, 100000, 500000, 1000000, 10000000, 50000000],
            colorGroupingField: "total",
            label: {
                enabled: true,
                dataField: "name"
            },
            customize: function (elements) {
                $.each(elements, function (_, element) {
                    var countryGDPData = countriesGDP[element.attribute("name")];
                    element.attribute("total", countryGDPData && countryGDPData.total || 0);
                });
            }        
        },
        legends: [{
            source: { layer: "areas", grouping: "color" },
            customizeText: function (arg) {
                return format(arg.start) + " to " + format(arg.end);
            }
        }],
        title: {
            text: "Nominal GDP",
            subtitle: {
                text: "(in millions of US dollars)"
            }
        },
        "export": {
            enabled: true
        },
        tooltip: {
            enabled: true,
            customizeTooltip: function (arg) {
                var countryGDPData = countriesGDP[arg.attribute("name")];
                
                var node = $("<div>")
                    .append("<h4>" + arg.attribute("name") + "</h4>")
                    .append("<div id='nominal'></div>")
                    .append("<div id='gdp-sectors'></div>");
                
                var total = countryGDPData && countryGDPData.total;
                if (total)
                    node.find("#nominal").text("Nominal GDP: $" + format(total) + "M");
                
                return {
                    html: node.html()
                };
            }
        },
        onTooltipShown: function (e) {
            var name = e.target.attribute("name"),
                GDPData = [$.extend({ name: name }, countriesGDP[name])],
                container = $("#gdp-sectors");
            if (GDPData[0].services) {
                container.dxChart({
                    dataSource: GDPData,
                    title: {
                        text: "GDP sector composition",
                        font: { size: 16 }
                    },
                    argumentAxis: {
                        label: { visible: false }
                    },
                    valueAxis: {
                        label: { visible: false }
                    },
                    commonSeriesSettings: {
                        argumentField: "name",
                        type: "bar",
                        hoverMode: "allArgumentPoints",
                        selectionMode: "allArgumentPoints",
                        label: {
                            visible: true,
                            format: {
                                type: "fixedPoint",
                                precision: 1
                            },
                            customizeText: function (args) {
                                return args.value + "%";
                            }
                        },
                        valueAxis: {
                            max: 100,
                            min: 0
                        }
                    },
                    series: [{
                        valueField: "agriculture",
                        name: "agriculture"
                    }, {
                        valueField: "industry",
                        name: "industry"
                    }, {
                        valueField: "services",
                        name: "services"
                    }],
                    legend: {
                        orientation: "horizontal",
                        horizontalAlignment: "center",
                        verticalAlignment: "bottom"
                    }
                });
            } else {
                container.text("No economic development data");
            }
    
        },
        bounds: [-180, 85, 180, -60]
    });
});