window.onload = function() {
    var viewModel = {
        panoramaData: panoramaData,
        background: {
            width: 800,
            height: 600,
            url: "../../../../images/cities/28.jpg"
        },
        clickHandler: function (e) {
            DevExpress.ui.dialog.alert("The \"" + 
                e.itemData.header + 
                "\" item is selected.", "Click Handler");
        }
    };
    ko.applyBindings(viewModel, document.getElementById("panorama"));
};