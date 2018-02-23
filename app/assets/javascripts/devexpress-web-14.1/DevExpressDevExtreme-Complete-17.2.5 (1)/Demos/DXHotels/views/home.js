"use strict";

DXHotels.home = function () {
    var model = this,
        MAX_SHOWN_IMAGES = 9,
        FRIDAY = 5;
    model.closeOffer = function () {
        var offer = this;
        model.offers($.grep(model.offers(), function (item) {
            return item.name != offer.name;
        }));
    };

    model.searchData = {
        location: ko.observable(null),
        rooms: ko.observable(),
        children: ko.observable(),
        adults: ko.observable(),
        checkIn: ko.observable(),
        checkOut: ko.observable()
    };

    model.offers = ko.observableArray([
        { name: "first" },
        { name: "second" },
        { name: "third" }
    ]);

    model.selectBoxData = ko.observable();
    model.loading = ko.observable("Loading...");
    model.minDateCheckOut = ko.observable();
    model.minDateCheckIn = ko.observable();
    model.maxDateCheckOut = ko.observable();
    model.indexImg = ko.observable(0);
    model.hotel = ko.observableArray();
    model.transformSlider = ko.observable(false);
    model.galleryData = ko.observableArray();
    model.numberOfRooms = [1, 2, 3, 4];
    model.numberOfAdults = [1, 2, 3, 4];
    model.numberOfChildren = [0, 1, 2, 3, 4];

    var initDate = function () {
        var today = new Date();
        var minDate = new Date();
        var maxDateCheckOut = new Date();
        model.minDateCheckOut(today);
        minDate.setDate(today.getDate());
        maxDateCheckOut.setDate(minDate.getDate() + 31);
        model.minDateCheckIn(minDate);
        model.maxDateCheckOut(maxDateCheckOut);
    };
    initDate();

    model.init = function () {
        DXHotels.loadData({
            request: "cities"
        }).done(function (data) {
            model.selectBoxData(data);
            model.loading(" ");
            $(".search-form").dxForm("instance").repaint();
        });

        DXHotels.loadData({
            request: "specialoffers"
        }).done(function (data) {
            var img = [];
            for (var i = 0 ; i < data.length; i++) {
                var hotel = data[i];
                img.push({
                    index: i,
                    cityId: hotel.City_Id,
                    hotelId: hotel.Id,
                    location: hotel.City + ", " + hotel.Country,
                    src: hotel.CIty_Image,
                    price: "$" + parseInt(hotel.Price),
                    name: hotel.Hotel_Name
                });
            }
            model.galleryData(img);
        });
    };

    model.changePicture = function () {
        model.indexImg(this.index);
    };

    model.indexImg.subscribe(function (newValue) {
        if (newValue == MAX_SHOWN_IMAGES)
            model.transformSlider(true);
        else if (newValue === 0)
            model.transformSlider(false);
    });

    model.searchData.checkIn.subscribe(function (newValue) {
        DXHotels.getMaxDate(newValue, model);
    });

    var getSpecialOfferDate = function () {
        var checkInOffer = new Date(),
            dayWeek = checkInOffer.getDay();
        if(dayWeek != FRIDAY)
            checkInOffer.setDate(checkInOffer.getDate() + FRIDAY - dayWeek);
        var checkOutOffer = new Date(checkInOffer);
        checkOutOffer.setDate(checkInOffer.getDate() + 2);
        return { startDate: checkInOffer, endDate: checkOutOffer };
    };

    model.specialOffers = function (data) {
        var checkInOffer = getSpecialOfferDate();
        DXHotels.app.navigate({
            view: "currentHotel",
            rooms: "1",
            children: "",
            adults: "1",
            checkIn: DXHotels.getDate(checkInOffer.startDate),
            checkOut: DXHotels.getDate(checkInOffer.endDate),
            hotelId: data.itemData.hotelId,
            city: data.itemData.cityId,
        });
    };

    model.searchClick = function (params) {
        var result = $(".search-form").dxForm("instance").validate();
        if (result.isValid) {
            DXHotels.app.navigate({
                view: "hotels",
                city: model.searchData.location(),
                rooms: model.searchData.rooms(),
                adults: model.searchData.adults(),
                children: model.searchData.children(),
                checkIn: DXHotels.getDate(model.searchData.checkIn()),
                checkOut: DXHotels.getDate(model.searchData.checkOut())
            });
        }
    };

    model.init();

    return model;
};