$(function(){
    var pivotData = [
            {
                title: "All",
                listData: new DevExpress.data.DataSource({
                    store: contacts,
                    sort: "name"
                })
            },
            {
                title: "Family",
                listData: new DevExpress.data.DataSource({
                    store: contacts,
                    sort: "name",
                    filter: ["category", "=", "Family"]
                })
            },
            {
                title: "Friends",
                listData: new DevExpress.data.DataSource({
                    store: contacts,
                    sort: "name",
                    filter: ["category", "=", "Friends"]
                })
            },
            {
                title: "Work",
                listData: new DevExpress.data.DataSource({
                    store: contacts,
                    sort: "name",
                    filter: ["category", "=", "Work"]
                })
            }
        ];

    $("#pivot").dxPivot({
        dataSource: pivotData,
        itemTemplate: function(itemData, itemIndex, itemElement) {
            $("<div/>").dxList({
                dataSource: itemData.listData,
                itemTemplate: function(itemData, itemIndex, itemElement) {
                    var $imageContainer = $("<div />").addClass("image-container");
                    $("<div />").css("background-image", "url('" + itemData.image + "')").appendTo($imageContainer);
                    var $infoContainer = $("<div />").addClass("info");
                    $infoContainer.append(
                        $("<div />").text(itemData.name),
                        $("<div />").text(itemData.phone),
                        $("<div />").text(itemData.email)
                    );
                    itemElement.append($imageContainer, $infoContainer);
                }
            }).appendTo(itemElement);
        },
        onItemClick: function (e) {
            DevExpress.ui.dialog.alert("The current section: " +
                e.itemData.title, "Click Handler");
        },
    });
});