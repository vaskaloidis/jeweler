"use strict";

window.DXHotels = window.DXHotels || {};

DXHotels.apiPath = "https://js.devexpress.com/Demos/DXHotels/api/";

DXHotels.loadData = function (params) {
    var result = $.Deferred();
    var url = DXHotels.apiPath;
    if(params.request) url += params.request;
    if(params.filter) url += "?" + params.filter;
    if(params.limit) url += "&limit=" + params.limit;
    if(params.offset) url += "&offset=" + params.offset;
    
    $.get(url,
        function (data) {
            result.resolve(data);
        });

    return result.promise();
};

(function (DXHotels) {
    $(function () {
        DevExpress.devices.current("desktop");

        DXHotels.app = new DevExpress.framework.html.HtmlApplication({
            namespace: DXHotels,
            navigation: DXHotels.config.navigation,
            mode: "webSite",
            layoutSet: DevExpress.framework.html.layoutSets[DXHotels.config.layoutSet]
        });
        DXHotels.app.on("viewShowing", function() {
            $("html,body").scrollTop(0);
        });
        DXHotels.app.router.register(":view/:id", { view: "home", id: undefined });
        DXHotels.app.navigate();

        DXHotels.getParameterByName = function (name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.hash);
            return results === null ? "" : decodeURIComponent(results[1]);
        };        
    });
})(DXHotels);
