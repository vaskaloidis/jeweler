"use strict";

DXHotels.booking = function () {

    var model = {};

    model.currentIndex = ko.observable(0);
    model.adultsCurrent = ko.observable();
    model.shortDesc = ko.observable();
    model.description = ko.observable();
    model.totalDays = ko.observableArray();
    model.viewDays = ko.observableArray();
    model.price = ko.observable();
    model.totalPrice = ko.observable();
    model.fullAddress = ko.observable();
    model.featuresRoom = ko.observableArray();
    model.hotelName = ko.observable();
    model.checkIn = ko.observable();
    model.checkOut = ko.observable();
    model.cityName = ko.observable();
    model.roomDetails = ko.observable();
    model.selectMonthsAndYears = ko.observableArray();
    model.visiblePoints = ko.observable();
    model.printPreviewVisible = ko.observable(false);
    model.valueRadioGroup = ko.observable();
    model.dealsDiscountsVisible = ko.observable(false);
    model.customerRating = ko.observable();
    model.hotelImg = ko.observable();
    model.hotelImgPrint = ko.observable();
    model.listState = ko.observableArray();

    model.init = function () {
        var params = {
            adults: DXHotels.getParameterByName('adults'),
            hotelId: DXHotels.getParameterByName('hotelId'),
            children: DXHotels.getParameterByName('children'),
            roomId: DXHotels.getParameterByName('roomId'),
            checkIn: new Date(DXHotels.getParameterByName('checkIn')),
            checkOut: new Date(DXHotels.getParameterByName('checkOut'))
        };

        model.checkIn(formatDate(params.checkIn));
        model.checkOut(formatDate(params.checkOut));
        var totalDays = getTotalDays(params.checkIn, params.checkOut);
        if (totalDays.length > 3) {
            var days = totalDays.slice(0, 3);
            model.visiblePoints(true);
            model.viewDays(days);
        } else {
            model.visiblePoints(false);
            model.viewDays(totalDays);
        }

        model.viewDays();

        function formatDate(date) {
            return Globalize.formatDate(date, { skeleton: "yMd" });
        }
        function getTotalDays(checkIn, checkOut) {
            var days = [];
            while (checkIn <= checkOut) {
                days.push({ day: Globalize.formatDate(checkIn, { date: "full" }) });
                checkIn.setDate(checkIn.getDate() + 1);
            }
            return days;
        }

        model.adultsCurrent(params.adults);

        DXHotels.loadData({
            request: "hotel/" + params.hotelId,
        }).done(function (data) {
            var value = data[0];
            model.hotelName(value.Hotel_Name);
            model.description(value.Description);
            model.customerRating(value.Avg_Customer_Rating);
            var address = value.Address,
                postalCode = value.Postal_Code,
                city = value.City,
                stateProvince = value.StateProvince,
                country = value.Country;
            model.fullAddress(DXHotels.getFullAddress(address, city, stateProvince, postalCode, country));
        });

        DXHotels.loadData({
            request: "hotel/" + params.hotelId + "/images",
        }).done(function (data) {
            model.hotelImg(data[0].Image_Filename);
            model.hotelImgPrint(data[1].Image_Filename);
        });

        DXHotels.loadData({
            request: "hotel/" + params.hotelId + "/rooms/" + params.roomId
        }).done(function (data) {
            var features = [];

            for(var i = 0 ; i < data.length; i++) {
                var value = data[i];
                features.push({ feature: value.Feature_Name, icon: value.Icon });
                if(i == data.length - 1 || value.Id != data[i + 1].Id) {
                    var shortDesc = value.Room_Short_Description + ", " +
                    value.RoomType;
                    var description = shortDesc + ", Adults " + params.adults;
                    if(params.children) {
                        description += ", Children " + params.children;
                    }
                    model.featuresRoom(features.slice(0, 3));
                    model.price("$" + parseInt(value.Nighly_Rate) + ".00");
                    model.totalPrice("$" + (parseInt(value.Nighly_Rate) * totalDays.length) + ".00");
                    model.roomDetails(description);
                    model.shortDesc(shortDesc);
                    break;
                }
            }
        });

        model.offers = [
            { offer: "10-15% discount at Macy's stores" },
            { offer: "Exclusive offers - $500 value" }

        ];
        function getMonthAndYears() {
            var monthAndYear = [];
            var date = new Date();
            var year = date.getFullYear();
            for (var i = 1; i <= 12; i++) {
                monthAndYear.push({ month: i, year: year });
                year++;
            }
            return monthAndYear;
        }
        model.selectMonthsAndYears(getMonthAndYears());
    };

    model.listState = [
        { name: "Alabama" },
        { name: "Alaska" },
        { name: "Arizona" },
        { name: "Arkansas" },
        { name: "California" },
        { name: "Colorado" },
        { name: "Connecticut" },
        { name: "Delaware" },
        { name: "Florida" },
        { name: "Georgia" },
        { name: "Hawaii" },
        { name: "Idaho" },
        { name: "Illinois" },
        { name: "Illinois" },
        { name: "Iowa" },
        { name: "Kansas" },
        { name: "Kentucky" },
        { name: "Louisiana" },
        { name: "Maine" },
        { name: "Maryland" },
        { name: "Massachusetts" },
        { name: "Michigan" },
        { name: "Minnesota" },
        { name: "Mississippi" },
        { name: "Missouri" },
        { name: "Montana" },
        { name: "Nebraska" },
        { name: "Nevada" },
        { name: "New Hampshire" },
        { name: "New Jersey" },
        { name: "New Mexico" },
        { name: "New York" },
        { name: "North Carolina" },
        { name: "North Dakota" },
        { name: "Ohio" },
        { name: "Oklahoma" },
        { name: "Oregon" },
        { name: "Pennsylvania" },
        { name: "Rhode Island" },
        { name: "South Carolina" },
        { name: "South Dakota" },
        { name: "Tennessee" },
        { name: "Texas" },
        { name: "Utah" },
        { name: "Vermont" },
        { name: "Virginia" },
        { name: "Washington" },
        { name: "West Virginia" },
        { name: "Wisconsin" },
        { name: "Wyoming" }
    ];

    model.init();

    model.valueRadioGroup.subscribe(function () {
        model.dealsDiscountsVisible(true);
    });

    model.showPrintPreview = function () {
        model.printPreviewVisible(true);
    };

    return model;
};
