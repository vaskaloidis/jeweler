"use strict";

RealtorApp.Home = function (params) {
    var isPhone = DevExpress.devices.current().screenSize === "small",
        watchToken = null,
        loadPanelMessage = ko.observable(""),
        loadPanelVisible = ko.observable(false),
        isLoaded = $.Deferred(),
        listData = ko.observableArray([]),
        errorMessage = ko.observable(""),
        isSearchActive = ko.observable(false),
        locationHandled = false;

    function loadData() {
        RealtorApp.data.getBestOffers(isPhone ? 3 : 5).done(function (result) {
            $.each(result, function(index, item) {
                listData.push({
                    image: "url(" + item.Images[0] + ")",
                    price: Globalize.formatCurrency(item.Price, "USD", { maximumFractionDigits: 0 }),
                    priceCss: "price" + index,
                    doubleCss: index ? "item" + index : "double",
                    ID: item.ID
                });
            });
            isLoaded.resolve();
        });
    }
    
    function getCurrentPositionSuccess(position) {
        if (locationHandled) return;
        locationHandled = true;
        navigator.geolocation.clearWatch(watchToken);
        loadPanelVisible(false);
        RealtorApp.app.navigate(
            "Results/" +
            position.coords.latitude + "," +
            position.coords.longitude + 
            "/coordinates");
    }

    function getCurrentPositionFail(error) {
        if (locationHandled) return;
        locationHandled = true;
        navigator.geolocation.clearWatch(watchToken);
        switch (error.code) {
            case 1:
                errorMessage("The use of location is currently disabled.");
                break;
            default:
                errorMessage("Unable to detect current location. Please ensure location is turned on in your phone settings and try again.");
        }
        loadPanelVisible(false);
    }
    
    var viewModel = {
        listData: listData,
        isLoaded: isLoaded.promise(),
        loadPanelVisible: loadPanelVisible,
        loadPanelMessage: loadPanelMessage,
        errorMessage: errorMessage,
        isSearchActive: isSearchActive,
        errorVisible: ko.computed(function() {
            return errorMessage().length !== 0;
        }),
        hideError: function() {
            errorMessage("");
        },
        text: ko.observable(""),
        homeItemClick: function(object) {
            RealtorApp.app.navigate("Details/" + object.model.ID);
        },
        searchItemClick: function () {
            if (!this.text()) {
                errorMessage("Please enter the search string.");
                return;
            }
            RealtorApp.app.navigate("Results/" + this.text() + "/searchstring");
        },
        locationItemClick: function () {
            locationHandled = false;
            loadPanelVisible(true);
            errorMessage("");
            loadPanelMessage("Getting coordinates. Please wait...");
            if (navigator.geolocation)
                watchToken = navigator.geolocation.watchPosition(getCurrentPositionSuccess, getCurrentPositionFail);
            else {
                errorMessage("Geolocation is not supported by this device.");
            }
            setTimeout(function () {
                getCurrentPositionFail({ code: 3 });
            }, 5000);
        },
        viewShowing: function (args) {
            isSearchActive(false);
        },
        viewRendered: function() {
            loadData();
        },
        showSearchControls: function() {
            if (!isSearchActive()) {
                isSearchActive(true);
                setTimeout(function () {
                    $(".search-text").data("dxTextBox").focus();
                }, 500);  
            }
        }
        
    };

    return viewModel;
};