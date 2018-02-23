"use strict";

window.DXHotels = window.DXHotels || {};

DXHotels.LayoutModel = function () {
    var self = this;
    var USER_NAME_KEY = "userName";

    self.copyrightDate = ko.observable(new Date().getFullYear());
    self.contactPopupVisible = ko.observable(false);
    self.loginPopupVisible = ko.observable(false);
    self.userName = ko.observable("");

    self.init = function () {
        var userName = DXHotels.getCookie(USER_NAME_KEY);
        if (userName) {
            self.userName(userName);
        }
    };

    self.showContactPopup = function () {
        self.contactPopupVisible(true);
    };
    self.hideContactPopup = function () {
        self.contactPopupVisible(false);
    };

    self.showLoginPopup = function () {
        self.loginPopupVisible(true);
    };
    self.hideLoginPopup = function () {
        self.loginPopupVisible(false);
    };

    self.showWelcome = function (params) {
        var result = null;
        result = $(".loginFormActive").dxForm("instance");
        if (result.validate().isValid) {
            var data = null;
            data = result.option("formData");
            self.hideLoginPopup();
            self.userName(data.login);
        }
    };

    self.userName.subscribe(function (newValue) {
        DXHotels.setCookie(USER_NAME_KEY, newValue);
    });

    self.logoClick = function () {
        DXHotels.app.navigate({
            view: "home"
        });
    };

    self.loginPopupVisible.subscribe(function (newValue) {
        var groupConfig;
        if(newValue) {
            groupConfig = DevExpress.validationEngine.getGroupConfig(self);
            if(groupConfig) {
                groupConfig.reset();
            }
        }
    });

    self.init();
};

DXHotels.layoutModel = new DXHotels.LayoutModel();