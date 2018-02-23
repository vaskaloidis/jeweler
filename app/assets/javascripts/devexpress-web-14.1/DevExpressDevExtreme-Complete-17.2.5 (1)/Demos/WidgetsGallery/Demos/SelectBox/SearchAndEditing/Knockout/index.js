window.onload = function() {
    var currentProduct = ko.observable(simpleProducts[0]),
        currentProducts = ko.observableArray(simpleProducts);
    
    var viewModel = {
        currentProduct: currentProduct,
        searchOptions: {
            items: products,
            displayExpr: "Name",
            valueExpr: "ID",
            searchEnabled: true
        },
        fieldEditingOptions: {
            items: currentProducts,
            value: currentProduct,
            acceptCustomValue: true,
            onCustomItemCreating: function(data) {
                var newItem = data.text;
                currentProducts.push(newItem);
                return newItem;
            }
        },

    };
    
    ko.applyBindings(viewModel, document.getElementById("select-box-demo"));
};