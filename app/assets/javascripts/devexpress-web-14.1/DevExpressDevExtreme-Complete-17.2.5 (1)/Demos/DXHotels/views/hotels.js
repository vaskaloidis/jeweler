"use strict";

DXHotels.hotels = function () {

    var model = {},
        city = DXHotels.getParameterByName('city'),
        CHECKBOX_STAR_NUMBER = 5,
        MAX_CUSTOMER_RATING = 5;

    var params = {
        checkIn: DXHotels.getParameterByName('checkIn'),
        checkOut: DXHotels.getParameterByName('checkOut'),
        rooms: DXHotels.getParameterByName('rooms'),
        adults: DXHotels.getParameterByName('adults'),
        children: DXHotels.getParameterByName('children'),
        city: city
    };
    var getFilterString = function (params) {
        var paramsArray = [];

        if(params.customerRating) paramsArray.push("customerRating=" + params.customerRating);
        if(params.rangeEnd) paramsArray.push("rangeEnd=" + params.rangeEnd);
        if(params.rangeStart) paramsArray.push("rangeStart=" + params.rangeStart);
        if(params.ourRating) paramsArray.push("ourRating=" + params.ourRating);
        if(params.startswithHotelName) paramsArray.push("startswithHotelName=" + params.startswithHotelName);
        if(params.locationRating) paramsArray.push("locationRating=" + params.locationRating);

        return paramsArray.join("&");
    };

    model.nameHotel = ko.observable("");
    model.resultDate = ko.observable();
    model.resultAdults = ko.observable("");
    model.cityOnMap = ko.observable({lat: 0, lng: 0});
    model.location = ko.observable();
    model.pages = ko.observableArray();
    model.hotels = ko.observableArray();
    model.currentHotelName = ko.observable();
    model.currentPage = ko.observable(1);
    model.amountHotel = ko.observable();
    model.allCities = ko.observable();
    model.currentHotels = ko.observableArray();
    model.rangeStart = ko.observable(0);
    model.rangeEnd = ko.observable(1000);
    model.resultRange = ko.observable();
    model.currentCity = ko.observable(city);
    model.currentCityName = ko.observable();
    model.visibleCustomerRating = ko.observable();
    model.visibleRange = ko.observable();
    model.avgRating = ko.observable();
    model.customerRating = ko.observable(MAX_CUSTOMER_RATING);
    model.locationRating = ko.observable();
    model.resultRating = ko.observable();
    model.countHotels = ko.observable();

    var updateCheckboxStarsArray = function () {
        
        var checkboxStars = [];

        for(var i = 1; i <= CHECKBOX_STAR_NUMBER; i++) {
            var checkboxStar = {
                checked: ko.observable(false),
                count: i
            };

            checkboxStar.checked.subscribe(function () {
                refreshHotelsAndHotelName();
            });

            checkboxStars.push(checkboxStar);
        }
        if(!model.checkboxStars) {
            model.checkboxStars = ko.observableArray();
        }
        model.checkboxStars(checkboxStars);
    };
    updateCheckboxStarsArray();

    model.resultStars = ko.observable();

    model.closeCurrentCity = function () {
        DXHotels.app.navigate({
            view: "home"
        });
    };

    model.closeRange = function () {
        model.visibleRange(false);
        model.rangeStart(0);
        model.rangeEnd(1000);
    };

    model.closeCurrentHotelName = function () {
        closeHotelName();
    };

    var closeHotelName = function () {
        if(model.currentHotelName() === null)
            return true;
        model.currentHotelName(null);
        return false;
    };

    var refreshHotelsAndHotelName = function () {
        if(closeHotelName()) {
            getCorrectHotels();
            getHotelNames();
        }
    };

    model.closeResultStars = function () {
        updateCheckboxStarsArray();
        getCorrectHotels();
        getHotelNames();
    };

    model.closeCustomerRating = function () {
        model.customerRating(MAX_CUSTOMER_RATING);
        model.visibleCustomerRating(false);
    };
    model.closeLocation = function () {
        model.locationRating(null);
    };

    var setDataCity = function (data) {
        setLocation(data[0].Country, data[0].City, data[0].StateProvince);
    };

    var getOurRating = function () {
        var ourRatingsArray = $.grep(model.checkboxStars(), function (item) { return item.checked(); });

        if (ourRatingsArray.length === 0) {
            model.resultStars("");
            return "";
        }
        
        var ratingStars = ourRatingsArray.map(function (elem) {
            return elem.count;
        });

        model.resultStars(ratingStars.join(", ") + " Stars");

        return ratingStars.join(",");
    };

    var setLocation = function (country, city, stateProvince) {
        if (stateProvince) {
            model.location(city + ', ' + stateProvince + ', ' + country);
        }
        else {
            model.location(city + ', ' + country);
        }

        model.cityOnMap(country + ',' + stateProvince + ',' + city);
    };

    var validateParams = function (params) {
        if (params.checkIn && params.checkOut && params.rooms && params.adults) {
            return true;
        }
        else {
            params.view = "home";
            DXHotels.app.navigate(params);
            return false;
        }
    };
    model.toolRateNightly = {
        enabled: true,
        format: function (value) {
            return "$" + value;
        },
        showMode: 'always'
    };

    model.init = function () {
        model.resultDate(DXHotels.getDateForView(params.checkIn, params.checkOut, "hotels"));
        model.resultAdults(DXHotels.getAdults(params.checkIn, params.checkOut, params.rooms, params.adults, params.children));
        if(validateParams(params)) {
            model.currentHotelName(null);
            DXHotels.loadData({
                request: "cities/" + city
            }).done(function (data) {
                model.currentCityName(data[0].City);
                setDataCity(data);
            });
        }
    };

    var getHotels = function (data) {
        var curHotels = [];
        for (var i = 0 ; i < data.length; i++) {
            var value = data[i],
                address = value.Address,
                postalCode = value.Postal_Code,
                city = value.City,
                stateProvince = value.StateProvince,
                country = value.Country,
                nightlyRate = value.Price;

            curHotels.push({
                name: value.Hotel_Name,
                hotelClass: value.Hotel_Class,
                description: value.Description,
                avgRating: value.Avg_Customer_Rating,
                src: value.Image_Filename,
                locationRating: value.Location_Rating,
                fullAdrs: DXHotels.getFullAddress(address, city, stateProvince, postalCode, country),
                ourRating: parseInt(value.Our_Rating),
                nightlyRate: "$" + parseInt(nightlyRate),
                hotelId: value.Id,
                roomId: value.RoomId
            });
        }
        model.currentHotels(curHotels);
    };

    model.countHotels.subscribe(function (newValue) {
        var pages = [];
        var countPage = Math.floor((newValue - 1) / 3 + 1);
        for (var i = 1; i <= countPage ; i++) {
            pages.push({ number: i });
        }
        model.pages(pages);

        model.currentPage(1);
        if (newValue > 1 || newValue === 0) {
            model.amountHotel(newValue + " HOTELS");
        } else model.amountHotel(newValue + " HOTEL");

    });

    model.selectedPage = function () {
        model.currentPage(this.number);
    };

    var getHotelNames = function () {
        DXHotels.loadData({
            request: "hotels/" + model.currentCity(),
            filter: getFilterString({
                customerRating: model.customerRating(),
                rangeEnd: model.rangeEnd(),
                rangeStart: model.rangeStart(),
                ourRating: getOurRating(),
                locationRating: model.locationRating()
            })
        }).done(function (data) {
            var hotels = [];
            for (var i = 0 ; i < data.length; i++) {
                hotels.push({
                    id: data[i].ID,
                    name: data[i].Hotel_Name
                });
            }
            model.countHotels(model.currentHotelName() ? 1 : data.length);
            model.hotels(hotels);
        });
    };

    var getCorrectHotels = function () {
        var COUNT_ITEMS_ON_PAGE = 3;
        var offset = model.currentPage() * COUNT_ITEMS_ON_PAGE - COUNT_ITEMS_ON_PAGE;
        DXHotels.loadData(
        {
            request: "hotels/" + model.currentCity(),
            filter: getFilterString({
                customerRating: model.customerRating(),
                rangeEnd: model.rangeEnd(),
                rangeStart: model.rangeStart(),
                ourRating: getOurRating(),
                startswithHotelName: model.currentHotelName(),
                locationRating: model.locationRating()
            }),
            limit: COUNT_ITEMS_ON_PAGE,
            offset: offset

        }).done(function (data) {
            getHotels(data);
        });
    };

    model.locRating = [ "AAA", "AA", "A", "BBB" ];

    var rangeTimeout;
    var changeRange = function () {
        clearTimeout(rangeTimeout);

        var updateHotels = function () {
            if (model.rangeStart() != model.rangeEnd()) {
                refreshHotelsAndHotelName();
                if ((model.rangeStart() !== 0) || (model.rangeEnd() != 1000)) {
                    model.visibleRange(true);
                }
                else {
                    model.visibleRange(false);
                }
            } else {
                model.visibleRange(true);
                model.countHotels(0);
                getHotels([]);
            }
        };

        rangeTimeout = setTimeout(updateHotels, 300);
    };

    model.rangeEnd.subscribe(function (newValue) {
        changeRange();
    });

    model.rangeStart.subscribe(function (newValue) {
        changeRange();
    });

    model.customerRating.subscribe(function (newValue) {
        refreshHotelsAndHotelName();
        if(newValue != MAX_CUSTOMER_RATING) {
            
            model.resultRating('Rating ' + newValue);
            model.visibleCustomerRating(true);
        } else {
            model.visibleCustomerRating(false);
        }
    });

    model.currentPage.subscribe(getCorrectHotels);

    model.currentHotelName.subscribe(function (newValue) {
        getCorrectHotels();
        getHotelNames();
    });

    model.locationRating.subscribe(refreshHotelsAndHotelName);

    model.disableNext = ko.computed(function () { return model.currentPage() == model.pages().length; });
    model.disablePrev = ko.computed(function () { return model.currentPage() == 1; });

    model.nextPage = function () {
        if(!model.disableNext())
            model.currentPage(model.currentPage() + 1);
    };

    model.previousPage = function () {
        if(!model.disablePrev())
            model.currentPage(model.currentPage() - 1);
    };

    model.resultRange = ko.computed(function () {
        return "$" + model.rangeStart() + "-" + "$" + model.rangeEnd();

    }, model);

    model.init();
    model.goToHotel = function () {
        DXHotels.app.navigate({
            view: "currentHotel",
            city: city,
            rooms: params.rooms,
            children: params.children,
            adults: params.adults,
            checkIn: Globalize.formatDate(new Date(params.checkIn), { skeleton: "yMd" }),
            checkOut: Globalize.formatDate(new Date(params.checkOut), { skeleton: "yMd" }),
            hotelId: this.hotelId
        });
    };

    model.goToBooking = function () {
        DXHotels.app.navigate({
            view: "booking",
            adults: params.adults,
            roomId: this.roomId,
            children: params.children,
            checkIn: DXHotels.getDate(params.checkIn),
            checkOut: DXHotels.getDate(params.checkOut),
            hotelId: this.hotelId
        });
    };

    return model;
};