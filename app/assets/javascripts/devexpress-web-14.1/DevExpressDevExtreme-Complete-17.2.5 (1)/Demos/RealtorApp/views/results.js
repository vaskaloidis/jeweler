"use strict";

RealtorApp.Results = function(params) {
    var isPhone = DevExpress.devices.current().screenSize === "small";
    var customTitle = ko.observable("");
    
    var ITEM_LIST = 0,
        ITEM_MAP = 1,
        ITEM_GALLERY = 2;

    var listData = ko.observableArray([]),
        isLoaded = $.Deferred(),
        isViewShown = $.Deferred(),
        isReady = $.when(isLoaded, isViewShown),
        mapMarkers = ko.observableArray([]),
        activeItem = ko.observable(ITEM_LIST);
      
    function initializeResult(result) {
        if(isLoaded.state() == "resolved") return;
        listData(result);
        mapMarkers(markersByCoordinates(result));
    }

    function loaded() {
        isLoaded.resolve();
    }

    function loadData() {
        if (params.type === 'searchstring') {
            if (!isPhone) customTitle(params.id);
            RealtorApp.data.getPropertiesByPlaceName(params.id)
                .done(initializeResult)
                .always(loaded);
        } else {
            if (!isPhone) customTitle("My location");
            RealtorApp.data.getPropertiesByCoordinates(params.id)
                .done(initializeResult)
                .always(loaded);
        }
        
    }
       
    function markersByCoordinates(array) {
        var markers = [];
        for (var i = 0; i < array.length; i++) {
            markers.push({ location: array[i].Coordinates, onClick: '#Details/' + array[i].ID });
        }
        return markers;
    }

    function getClassByIndex(index) {
        if(index === 0) return "list";
        if(index == 1) return "map";
        if(index == 2) return "gallery";
    }

    function getComputedIcon(itemIndex) {
        return ko.computed(function() {
            return getClassByIndex(itemIndex) + (activeItem() == itemIndex ? '-selected' : '');
        });
    }
   
    var viewModel = {
        title: customTitle,
        listData: listData,
        isReady: isReady.promise(),
        activeItem: activeItem,
        iconList: getComputedIcon(ITEM_LIST),
        mapMarkers: mapMarkers,
        iconMap: getComputedIcon(ITEM_MAP),
        iconGallery: getComputedIcon(ITEM_GALLERY),

        resultsItemClick: function(item) {
            RealtorApp.app.navigate("Details/" + item.model.ID);
        },
        goToList: function () {
            viewModel.activeItem(ITEM_LIST);
        },
        goToMap: function () {
            viewModel.activeItem(ITEM_MAP);
        },
        goToGallery: function () {
            viewModel.activeItem(ITEM_GALLERY);
        },
        viewShowing: function(args) {
            loadData();
        },
        viewShown: function() {
            isViewShown.resolve();
        }
    };

    return viewModel;
};