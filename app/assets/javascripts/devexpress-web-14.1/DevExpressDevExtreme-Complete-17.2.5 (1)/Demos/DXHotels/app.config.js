"use strict";

window.DXHotels = $.extend(true, window.DXHotels, {
    "config": {
        "layoutSet": "desktop",
        "navigation": [

            {
                title: "home",
                onExecute: "#home"
            },

            {
                title: "hotels",
                onExecute: "#hotels",
            },            
            {
                title: "booking",
                onExecute: "#booking",
            },
            {
                title: "currentHotel",
                onExecute: "#currentHotel",

            }

        ]
    }
});