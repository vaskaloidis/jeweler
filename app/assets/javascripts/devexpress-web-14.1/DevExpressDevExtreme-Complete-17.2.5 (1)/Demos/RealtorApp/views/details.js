"use strict";

RealtorApp.Details = function (params) {

    var MAP_CONTAINER = ".details #map",
        MAP_INNER = ".details.dx-active-view .map-inner",
        MAX_MAP_WIDTH = 640;

    var isPhone = DevExpress.devices.current().screenSize === "small",
        homeItem = ko.observable(null),
        images = ko.observableArray(),
        isLoaded = $.Deferred(),
        title = ko.observable(""),
        status = ko.observable(""),
        isLandscapeTablet = ko.observable(false);
    
    function loadData(id) {

        RealtorApp.data.getPropertyInfo(id).done(function(result) {
            if(isLoaded.state() == "resolved")
                return;
            images.removeAll();
            $.each(result.Images, function (_, image) {
                images.push("url(" + image + ")");
            });

            switch (result.Status) {
                case '0': status('Active');
                    break;
                case '1': status('Selling');
                    break;
                case '2': status('Sold');
                    break;
                default: status('Unknown');
            }

            homeItem(result);
            title(result.Address);
            isLoaded.resolve();
        });
    }

    var updateMap = function() {
        var mapHeight = "100%",
            mapWidth = "100%",
            provider = "bing",
            scrollElement = $(".dx-content-placeholder-content .tablet-scrollable");
        isLandscapeTablet($(".details .right .images .dx-gallery").css("width") == "760px");
        if (isPhone) {
            mapHeight = $(MAP_CONTAINER).height();
            mapWidth = $(MAP_CONTAINER).width();
            mapWidth = (mapWidth > MAX_MAP_WIDTH) ? MAX_MAP_WIDTH : mapWidth;
            provider = "googleStatic";
            scrollElement = $(".dx-content-placeholder-content .details");
        }

        var mapOptions = {
            center: homeItem().Coordinates,
            width: mapWidth,
            height: mapHeight,
            zoom: 12,
            provider: provider,
            markers: [{ location: homeItem().Coordinates }],
            markerIconSrc: "//js.devexpress.com/Demos/RealtorApp/images/map-marker.png"
        };

        if($(MAP_INNER).data("dxMap") == null) {
            mapOptions.key = { googleStatic: "AIzaSyDk2m6n8ICK7FSmTHBLlapAWF3epiDdkHE" };
        }
        $(MAP_INNER).dxMap(mapOptions);
        scrollElement.dxScrollView({});
        scrollElement.data("dxScrollView").scrollTo(0);
    };

    var viewModel = {
        //  Put the binding properties here
        homeItem: homeItem,
        images: images,
        isLoaded: isLoaded.promise(),
        isPhone: isPhone,
        title: title,
        status: status,
        favButtonText: ko.observable(null),
        viewShowing: function () {
            loadData(params.id);
        },
        wrapAround: isLandscapeTablet,
        updateMap: updateMap
    };

    $(window).on("resize", function() {
        updateMap();
    });

    return viewModel;
};