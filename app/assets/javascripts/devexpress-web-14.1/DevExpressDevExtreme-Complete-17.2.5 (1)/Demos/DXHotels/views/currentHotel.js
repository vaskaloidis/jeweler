"use strict";

DXHotels.currentHotel = function () {
    var model = {},
        currentImageRoom = 0,
        HOTEL_FEATURES_NUMBER = 6;

    var Gallery = function () {
        var self = this;
        self.images = ko.observableArray();
        self.setImages = function (galleryId, images) {
            var imagesObjs = [];
            $.each(images, function (index, item) {
                imagesObjs.push({
                    galleryId: galleryId,
                    src: item.src,
                    index: index,
                    id: item.id
                });
            });
            self.images(imagesObjs);
        };
    };

    model.date = ko.observable();
    model.adultsCurrent = ko.observable();
    model.description = ko.observable();
    model.fullAddress = ko.observable();
    model.hotelName = ko.observable();
    model.customerRating = ko.observable();
    model.visibleSearch = ko.observable(false);
    model.reviews = ko.observableArray();
    model.features = ko.observable();
    model.featuresRoom = ko.observable();
    model.roomDesc = ko.observableArray();
    model.minDateCheckOut = ko.observable();
    model.minDateCheckIn = ko.observable(new Date());
    model.maxDateCheckOut = ko.observable();
    model.currentImageHotel = ko.observable(0);
    model.currentImageRoom = ko.observable(0);
    model.roomGallery = ko.observableArray([]);
    model.scrollRight = ko.observable(false);
    model.selectedAccItem = ko.observable();
    model.roomImg = ko.observable();
    model.popupRoomVisible = ko.observable(false);
    model.numberOfRooms = [1, 2, 3, 4];
    model.numberOfAdults = [1, 2, 3, 4];
    model.numberOfChildren = [0, 1, 2, 3, 4];

    var params = {
        city: DXHotels.getParameterByName('city'),
        rooms: DXHotels.getParameterByName('rooms'),
        adults: DXHotels.getParameterByName('adults'),
        hotelId: DXHotels.getParameterByName('hotelId'),
        children: DXHotels.getParameterByName('children'),
        checkIn: DXHotels.getParameterByName('checkIn'),
        checkOut: DXHotels.getParameterByName('checkOut')
    };

    model.searchData = {
        location: ko.observable(parseInt(params.city, 10)),
        rooms: ko.observable(parseInt(params.rooms)),
        children: ko.observable(parseInt(params.children) || ""),
        adults: ko.observable(parseInt(params.adults)),
        checkIn: ko.observable(new Date(params.checkIn)),
        checkOut: ko.observable(new Date(params.checkOut))
    };

    model.roomGalleryReadyAction = function (e) {
        model.currentImageRoom(currentImageRoom);
    };

    model.hotelGallery = ko.observable(new Gallery());

    var getHotel = function (id) {
        DXHotels.loadData({
            request: "hotel/" + id
        }).done(function (data) {
            var value = data[0];
            model.hotelName(value.Hotel_Name);
            model.customerRating(value.Avg_Customer_Rating);
            model.description(value.Description);

            model.fullAddress(DXHotels.getFullAddress(value.Address, value.City, value.StateProvince, value.Postal_Code, value.Country));
        });

        DXHotels.loadData({
            request: "hotel/" + id + "/images"
        }).done(function (data) {
            var images = [];

            for(var i = 0; i < data.length; i++) {
                images.push({ id: i, src: data[i].Image_Filename });
            }
            model.hotelGallery().setImages(i, images);
        });
    };

    var initDate = function () {
        model.minDateCheckOut(new Date(model.searchData.checkIn().getTime() + 1000 * 60 * 60 * 24 * 1));
        model.maxDateCheckOut(new Date(model.searchData.checkIn().getTime() + 1000 * 60 * 60 * 24 * 30));
    };
    initDate();

    model.init = function () {
        model.date(DXHotels.getDateForView(params.checkIn, params.checkOut, "currentHotel"));
        model.adultsCurrent(DXHotels.getAdults(params.checkIn, params.checkOut, params.rooms, params.adults, params.children));
        getHotel(params.hotelId);
        model.selectedAccItem(0);
        DXHotels.loadData({
            request: "hotel/" + params.hotelId  + "/reviews"
        }).done(function (data) {
            var reviews = [];
            for (var i = 0; i < data.length; i++) {
                var value = data[i];
                reviews.push({ review: value.Review, postedOn: Globalize.formatDate(new Date(value.Posted_On), { date: "medium" }), rating: value.Rating });
            }
            model.reviews(reviews);
        });

        DXHotels.loadData({
            request: "hotel/" + params.hotelId + "/features"
        }).done(function (data) {
            var features = [];
            for(var i = 0; i < HOTEL_FEATURES_NUMBER; i++) {
                features.push({ feature: data[i].Description });
            }
            model.features(features);
        });

        DXHotels.loadData({
            request: "cities"
        }).done(function (data) {
            model.selectBoxData(data);
        });

        var loadRooms = function () {
            DXHotels.loadData({
                request: "hotel/" + params.hotelId + "/rooms"
            }).done(function (data) {
                var descRooms = [];
                var features = [];
                for(var i = 0 ; i < data.length; i++) {
                    var value = data[i];
                    features.push({ feature: value.Feature_Name, icon: value.Icon });
                    if(i == data.length - 1 || value.Id != data[i + 1].Id) {
                        var gallery = new Gallery();
                        gallery.setImages(value.Id, [
                            { src: value.Room_Image1 },
                            { src: value.Room_Image2 },
                            { src: value.Room_Image3 },
                            { src: value.Room_Image4 },
                            { src: value.Room_Image5 }
                        ]);

                        descRooms.push({
                            title: {
                                index: i,
                                id: value.Id,
                                shortDescription: value.Room_Short_Description,
                                nightlyRate: "$" + parseInt(value.Nighly_Rate),
                            },
                            text: {
                                featuresPart1: features.slice(0, 3),
                                featuresPart2: features.slice(3, 6),
                                roomType: value.RoomType,
                                roomGalleries: gallery.images,
                                shortDescription: value.Room_Short_Description,
                            }
                        });
                        features = [];
                    }
                }
                model.roomDesc(descRooms);
            });
        };

        loadRooms();
    };

    model.selectBoxData = ko.observable([]);

    model.galleryRight = function () {
        model.scrollRight(true);
    };

    model.resetScroll = function () {
        model.scrollRight(false);
    };

    model.selectedIndexHotel = function (data) {
        model.currentImageHotel(data.index);
    };

    model.selectedIndexRoom = function (data) {
        model.currentImageRoom(data.index);
    };

    model.openRoomGallery = function (newValue) {
        DXHotels.loadData({
            request: "roomimages/" + newValue.galleryId
        }).done(function (data) {
            var images = data[0];
            var imagesRoom = [
                { index: 0, src: images.Room_Image1 },
                { index: 1, src: images.Room_Image2 },
                { index: 2, src: images.Room_Image3 },
                { index: 3, src: images.Room_Image4 },
                { index: 4, src: images.Room_image5 }
            ];
            currentImageRoom = newValue.index;
            model.roomGallery(imagesRoom);
            model.popupRoomVisible(true);
        });
    };

    model.showSearch = function () {
        model.visibleSearch(true);
    };

    model.searchData.checkIn.subscribe(function (newValue) {
        DXHotels.getMaxDate(newValue, model);
    });

    model.searchClick = function () {
        if ($(".change-search-form").dxForm("instance").validate().isValid) {
            model.visibleSearch(false);
            DXHotels.app.navigate({
                view: "hotels",
                city: model.searchData.location(),
                rooms: model.searchData.rooms(),
                adults: model.searchData.adults(),
                children: model.searchData.children(),
                checkIn: DXHotels.getDate(model.searchData.checkIn()),
                checkOut: DXHotels.getDate(model.searchData.checkOut())
            });
        }
    };

    model.booking = function () {
        DXHotels.app.navigate({
            view: "booking",
            adults: params.adults,
            roomId: this.title.id,
            children: params.children,
            checkIn: DXHotels.getDate(params.checkIn),
            checkOut: DXHotels.getDate(params.checkOut),
            hotelId: params.hotelId
        });
    };

    model.init();

    return model;
};

