$(function() {
    $("#filterBuilder").dxFilterBuilder({
        fields: fields,
        value: filter
    });

    $("#filterBuilder").dxScrollView({ direction: "both" });

    $("#listWidget").dxList({
        dataSource: new DevExpress.data.DataSource({
            store: products,
            filter: filter
        }),
        height: "100%",
        itemTemplate: function(data, index) {
            var result = $("<div>").addClass("product");
            $("<img>").attr("src", data.ImageSrc).appendTo(result);
            $("<div>").text(data.Name).appendTo(result);
            $("<div>").addClass("price")
                .html(Globalize.formatCurrency(data.Price, "USD", { maximumFractionDigits: 0 })).appendTo(result);
            return result;
        }
    });

    $("#apply").dxButton({
        text: "Apply Filter",
        type: "default",
        onClick: function() {
            var filter = $("#filterBuilder").dxFilterBuilder("instance").option("value"),
                dataSource = $("#listWidget").dxList("instance").getDataSource();
            dataSource.filter(filter);
            dataSource.load();
        },
    });
});