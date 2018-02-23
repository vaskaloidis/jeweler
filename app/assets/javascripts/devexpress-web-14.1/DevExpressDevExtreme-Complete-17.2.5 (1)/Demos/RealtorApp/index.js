"use strict";

window.RealtorApp = window.RealtorApp || {};

var realDevice = DevExpress.devices.real();
window.isWinPhone = realDevice.platform == "win" && realDevice.phone === true;

$(function () {
    DevExpress.devices.current().platform = "generic";

    function exitApp() {
        var exitMessage = "Are you sure you want to exit?";
        if (window.WinJS) {

            var msg = new Windows.UI.Popups.MessageDialog(exitMessage);

            msg.commands.append(new Windows.UI.Popups.UICommand("OK", function () {
                MSApp.terminateApp('');
            }));
            msg.commands.append(
                new Windows.UI.Popups.UICommand("Cancel"));

            msg.showAsync();
        } else if (confirm(exitMessage)) {
            navigator.app.exitApp();
        }
    }

    function onDeviceReady() {        
        document.addEventListener("backbutton", onBackButton, false);
        RealtorApp.app.on("navigatingBack", function (args) {
            if(!RealtorApp.app.canBack()) {
                args.cancel = true;
                exitApp();
            }
        });
        navigator.splashscreen.hide();
    }

    function onBackButton() {
        DevExpress.processHardwareBackButton();
    }

    RealtorApp.app = new DevExpress.framework.html.HtmlApplication({
        namespace: RealtorApp,
        layoutSet: DevExpress.framework.html.layoutSets[RealtorApp.config.layoutSet],
        animationSet: DevExpress.framework.html.animationSets[RealtorApp.config.animationSet],
        navigation: RealtorApp.config.navigation,
        navigateToRootViewMode: "keepHistory",
        commandMapping: RealtorApp.config.commandMapping,
        templatesVersion: "15.2.5"
    });
    RealtorApp.app.router.register(":view/:id/:type", { view: "Home", id: undefined, type: undefined });
    RealtorApp.app.on("viewShowing", function(args) {
        var viewInfo = args.viewInfo,
            layout = viewInfo.renderResult.$markup.closest(".navbar-layout");
        if(viewInfo.viewTemplateInfo.toolbar === false)
            layout.addClass("hide-toolbar");
        else
            layout.removeClass("hide-toolbar");
    });
   

    var device = DevExpress.devices.current();

    function setScreenSize() {
        if (window.isWinPhone) {
            device.screenSize = "small";
            $.each(document.styleSheets, function (index, element) {
                if (element.href) {
                    if (element.href.indexOf("index.small.css") >= 0) {
                        for (var i = element.media.length - 1; i >= 0; i--)
                            element.media.deleteMedium(element.media.item(i));
                    }
                    if (element.href.indexOf("index.medium.css") >= 0) {
                        element.disabled = true;
                    }
                }
            });
            return;
        }

        var el = $("<div>").addClass("screen-size").appendTo(".dx-viewport");

        setTimeout(function() {
            var size = getComputedStyle(el[0], "::after").content.replace(/["']/g, "");
            device.screenSize = size;
            el.remove();
        }, 0);

    }
    $(window).bind("resize", setScreenSize);
    setScreenSize();
    RealtorApp.app.navigate();

    document.addEventListener("deviceready", onDeviceReady, false);
});


(function () {
    var FAVES_STORAGE_KEY = 'realtorapp-favorites';

    var loadFavesFromStorage = function () {
        var rawFaves = localStorage.getItem(FAVES_STORAGE_KEY),
            faves = JSON.parse(rawFaves || '[]');
        $.each(faves, function (_, value) {
            if (typeof(value.HouseSize) == "string") {
                value.HouseSize = parseInt(value.HouseSize.replace(/,/g, ""));
            }
            if (typeof(value.Price) == "string") {
                value.Price = parseInt(value.Price.replace(/[,$]/g, ""));
            }
            value.IsFavorite = ko.observable(true);
        });
        return faves;
    };

    var saveFavesToStorage = function () {
        localStorage.setItem(FAVES_STORAGE_KEY, JSON.stringify(faves()));
    };
    
    var faves = ko.observableArray(loadFavesFromStorage());

    ko.computed(function () {
        saveFavesToStorage();
    });

    var findFavedProperty = function (property) {
        if (!property)
            return null;
        var result = $.grep(faves(), function (item) {
            return item.ID === property.ID;
        });
        return result[0];
    };

    $.extend(RealtorApp, {
        faves: faves,
        findFavedProperty: findFavedProperty,
        loadFavesFromStorage: loadFavesFromStorage,
        saveFavesToStorage: saveFavesToStorage
   });

})();