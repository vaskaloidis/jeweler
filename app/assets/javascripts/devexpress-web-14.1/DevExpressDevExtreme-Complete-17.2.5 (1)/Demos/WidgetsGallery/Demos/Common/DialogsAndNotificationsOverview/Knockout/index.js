window.onload = function() {
    var popupVisibility = ko.observable(false),
        currentHouse = ko.observable(houses[0]);

    function format(data) {
        return Globalize.formatNumber(data, { maximumfractiondigits: 0 });
    }

    function showHouse(data) {
        currentHouse(data);
        popupVisibility(true);
    }

    function changeFavoriteState(data) {
        var favoriteState = !data.model.Favorite,
            message = "This item has been "
            + (favoriteState ? "added to" : "removed from")
            + " the Favorites list!";
        data.model.Favorite = favoriteState;
        currentHouse(data.model);

        DevExpress.ui.notify({
            message: message,
            width: 450
        }, 
        favoriteState ? "success" : "error",
        2000);
    }

    var favoriteButtonText = ko.computed(function() {
        return currentHouse().Favorite
            ? "Remove from Favorites"
            : "Add to Favorites";
    });

    var viewModel = {
        houses: houses,
        showHouse: showHouse,
        currentHouse: currentHouse,
        popupVisibility: popupVisibility,
        changeFavoriteState: changeFavoriteState,
        favoriteButtonText: favoriteButtonText,
        format: format
    };

    ko.applyBindings(viewModel, document.getElementById("overview"));
};