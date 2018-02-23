window.onload = function() {
    var mapProviders = [{ 
            key: "google",
            name: "Google Dynamic Map"
        }, { 
            key: "googleStatic",
            name: "Google Static Map"
        }, { 
            key: "bing",
            name: "Bing Map"
        }],
        mapTypes = [{ 
            key: "roadmap",
            name: "Default Map"
        }, { 
            key: "satellite",
            name: "Photographic Map"
        }, { 
            key: "hybrid",
            name: "Hybrid Map"
        }];
    
    var provider = ko.observable(mapProviders[0].key),
        type = ko.observable(mapTypes[0].key);
    
    var viewModel = {   
        mapOptions: {
            center: "Brooklyn Bridge,New York,NY",
            zoom: 14,
            height: 400,
            width: "100%",
            provider: provider,
            type: type
        },
        chooseProviderOptions: {
            dataSource: mapProviders,
            displayExpr: "name",
            valueExpr: "key",
            value: provider
        },
        chooseTypeOptions: {
            dataSource: mapTypes,
            displayExpr: "name",
            valueExpr: "key",
            value: type
        }
    };
    
    ko.applyBindings(viewModel, document.getElementById("map-demo"));
};