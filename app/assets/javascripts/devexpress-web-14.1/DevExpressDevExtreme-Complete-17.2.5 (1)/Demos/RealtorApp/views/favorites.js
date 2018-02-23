"use strict";

RealtorApp.Favorites = function(params) {

    var isLoaded = $.Deferred();

    var viewModel = {
        noDataText: 'You have not added any properties to your favorites yet',
        favoritesItemClick: function (item) {
            RealtorApp.app.navigate("Details/" + item.model.ID);
        },
        viewShowing: function() {
            isLoaded.resolve();
        },
        isLoaded: isLoaded.promise()
    };

    return viewModel;
};