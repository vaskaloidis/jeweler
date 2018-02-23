$(function(){
    $("#panorama").dxPanorama({
        title: "Pictures",
        dataSource: panoramaData,
        backgroundImage: {
            width: 800,
            height: 600,
            url: "../../../../images/cities/28.jpg"
        },
        itemTemplate: function(itemData, itemIndex, itemElement) {
            $("<div/>").text(itemData.text).appendTo(itemElement);
            $.each(itemData.images, function(i, image){
                var $imageContainer = $("<div/>").addClass("image-container");
                $imageContainer.append(
                        $("<div />").addClass("image").css("background-image", "url('" + image.src + "')"),
                        $("<div />").text(image.text)
                    );
                $imageContainer.appendTo(itemElement);
            });
        },
        onItemClick: function (e) {
            DevExpress.ui.dialog.alert("The \"" + 
                e.itemData.header + 
                "\" item is selected.", "Click Handler");
        }
    });
    
    
});