window.onload = function() {
    var filterBuilderValue = ko.observable(filter),
        listFilter = ko.observable(filter);

    var viewModel = {
        filterBuilderOptions: {
            fields: fields,
            value: filterBuilderValue
        },

        scrollViewOptions: {
            direction: 'both'
        },

        buttonOptions: {
            text: "Apply Filter",
            type: "default",
            onClick: function() {
                listFilter(filterBuilderValue());
            },
        },

        listOptions: {
            dataSource: {
                store: products,
                filter: listFilter
            },
            height: "100%"
        }
    };

    ko.applyBindings(viewModel, document.getElementById("demo"));
};