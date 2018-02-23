$(function(){
    $("#productsSearch").dxSelectBox({
        items: products,
        displayExpr: "Name",
        valueExpr: "ID",
        searchEnabled: true
    });
    
    var editableProduct = $("#productsEditing").dxSelectBox({
        items: simpleProducts,
        value: simpleProducts[0],
        acceptCustomValue: true,
        onValueChanged: function (data) {
            $(".current-value").text(data.value);
        },
        onCustomItemCreating: function(data) {
            var newItem = data.text;
            simpleProducts.push(newItem);
            editableProduct.option("items", simpleProducts);
            return newItem;
        }
    }).dxSelectBox("instance");
});