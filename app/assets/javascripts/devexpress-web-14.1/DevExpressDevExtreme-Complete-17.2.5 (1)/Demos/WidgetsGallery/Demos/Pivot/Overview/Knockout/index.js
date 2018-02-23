window.onload = function() {
    var viewModel = {
        clickHandler: function (e) {
            DevExpress.ui.dialog.alert("The current section: " +
                e.itemData.title, "Click Handler");
        },
        pivotData: [
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
        ]
    };
    ko.applyBindings(viewModel, document.getElementById("pivot"));
};