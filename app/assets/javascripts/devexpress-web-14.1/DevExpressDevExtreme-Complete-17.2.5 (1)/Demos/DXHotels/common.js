"use strict";

window.DXHotels = window.DXHotels || {};

DXHotels.getAdults = function (checkIn, checkOut, rooms, adults, children) {
    var str = "";
    var nights = Math.ceil((
        new Date(checkOut).getTime() - new Date(checkIn).getTime()) / (1000 * 60 * 60 * 24));
    if((rooms !== "") || (adults !== "")) {
        str = 
            (nights + " night" + (nights > 1 ? "s" : "") + ", ") + 
            (rooms + " room" + (rooms > 1 ? "s" : "") + ", ") + 
            (adults + " adult" + (adults > 1 ? "s" : "")) + 
            ((children > 0) ? (", " + children + " child" + (children > 1 ? "ren" : "")) : "");
    }
    return str;
};

DXHotels.getDate = function (date) {
    return Globalize.formatDate(new Date(date), { skeleton: "yMd" });
};

DXHotels.getDateForView = function (checkIn, checkOut, view) {
    var resultDataFunc = "";
    var dateCheckIn = new Date(checkIn);
    var dateCheckOut = new Date(checkOut);
    var monthCheckIn = Globalize.formatDate(dateCheckIn, { raw: "MMMM" });
    var monthCheckOut = Globalize.formatDate(dateCheckOut, { raw: "MMMM" });
    if (monthCheckIn == monthCheckOut & dateCheckIn.getFullYear() == dateCheckOut.getFullYear()) {
        if (view == "hotels") {
            resultDataFunc = Globalize.formatDate(dateCheckIn, { raw: "EEE dd" }) + " - " + Globalize.formatDate(dateCheckOut, { raw: "EEE dd, MMM yyyy" });
        } else {
            resultDataFunc = Globalize.formatDate(dateCheckIn, { raw: "dd" }) + "-" + Globalize.formatDate(dateCheckOut, { raw: "dd, MMM yyyy" });
        }
    } else if (monthCheckIn != monthCheckOut) {
        if (view == "hotels") {
            resultDataFunc = Globalize.formatDate(dateCheckIn, { raw: "EEE dd, MMM yyyy" }) + " - " + Globalize.formatDate(dateCheckOut, { raw: "EEE dd, MMM yyyy" });
        } else {
            resultDataFunc = Globalize.formatDate(dateCheckIn, { raw: "dd, MMM yyyy" }) + " - " + Globalize.formatDate(dateCheckOut, { raw: "dd, MMM yyyy" });
        }
    }
    return resultDataFunc;
};

DXHotels.getFullAddress = function (address, city, stateProvince, postalCode, country) {     
    return address + " " + city + (stateProvince ? (", " + stateProvince) : "") + ", " + postalCode + ", " + country;
};

DXHotels.getMaxDate = function (newValue, model) {
    var MIN_NUMBER_OF_NIGHTS = 1;
    if (newValue) {
        if ((!model.searchData.checkOut()) || (model.searchData.checkOut() <= model.searchData.checkIn()) || ((Math.floor((model.searchData.checkOut() - model.searchData.checkIn()) / (1000 * 60 * 60 * 24))) > 30)) {
            var dateMax = new Date(newValue);
            model.searchData.checkOut(new Date(dateMax.getTime() + 1000 * 60 * 60 * 24 * MIN_NUMBER_OF_NIGHTS));
        }
        if (!model.searchData.rooms()) {
            model.searchData.rooms(1);
        }
        if (!model.searchData.adults()) {
            model.searchData.adults(1);
        }
    }
};

DXHotels.setCookie = function (name, value) {
    var cookieValue = name + "=" + encodeURIComponent(value) + ";";
    var currentDate = new Date(),
    cookiesFinishDate = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, currentDate.getDate());
    cookieValue += "expires=" + cookiesFinishDate.toUTCString() + ";";
    cookieValue += "path=/";

    document.cookie = cookieValue;
};
DXHotels.getCookie = function (name) {
    var matches = document.cookie.match(new RegExp(
      "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
    ));

    return matches ? decodeURIComponent(matches[1]) : undefined;
};