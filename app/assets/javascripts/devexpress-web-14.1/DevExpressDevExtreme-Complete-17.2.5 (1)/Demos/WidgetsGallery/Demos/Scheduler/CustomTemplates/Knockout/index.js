window.onload = function() {
    var schedulerOptions = {
        dataSource: data,
        views: ["day", "week", "timelineDay"],
        currentView: "day",
        currentDate: new Date(2015, 4, 25),
        firstDayOfWeek: 0,
        startDayHour: 9,
        endDayHour: 23,
        showAllDayPanel: false,
        height: 600,
        groups: ["theatreId"],
        crossScrollingEnabled: true,
        cellDuration: 20,
        editing: { 
            allowAdding: false
        },
        resources: [{ 
            fieldExpr: "movieId",
            dataSource: moviesData,
            useColorAsDefault: true
        }, { 
            fieldExpr: "theatreId", 
            dataSource: theatreData
        }],
        appointmentTooltipTemplate: "tooltip-template",
        appointmentTemplate: 'appointment-template',
        onAppointmentFormCreated: function(data) {
            var form = data.form,
                movieInfo = getMovieById(data.appointmentData.movieId) || {},
                startDate = data.appointmentData.startDate;
    
                form.option("items", [{
                    label: {
                        text: "Movie"
                    },
                    editorType: "dxSelectBox",
                    dataField: "movieId",
                    editorOptions: {
                        items: moviesData,
                        displayExpr: "text",
                        valueExpr: "id",
                        onValueChanged: function(args) {
                            movieInfo = getMovieById(args.value);
                            form.getEditor("director")
                                .option("value", movieInfo.director);
                            form.getEditor("endDate")
                                .option("value", new Date (startDate.getTime() +
                                    60 * 1000 * movieInfo.duration));
                        }
                    }
                }, {
                    label: {
                        text: "Director"
                    },
                    name: "director",
                    editorType: "dxTextBox",
                    editorOptions: {
                        value: movieInfo.director,
                        readOnly: true
                    }
                }, {
                    dataField: "startDate",
                    editorType: "dxDateBox",
                    editorOptions: {
                        type: "datetime",
                        onValueChanged: function(args) {
                            startDate = args.value;
                            form.getEditor("endDate")
                                .option("value", new Date (startDate.getTime() +
                                    60 * 1000 * movieInfo.duration));
                        }
                    }
                }, {
                    name: "endDate",
                    dataField: "endDate",
                    editorType: "dxDateBox",
                    editorOptions: {
                        type: "datetime",
                        readOnly: true
                    }
                }, {
                    dataField: "price",
                    editorType: "dxRadioGroup",
                    editorOptions: {
                        dataSource: [5, 10, 15, 20],
                        itemTemplate: function(itemData) {
                            return "$" + itemData;
                        }
                    }
                }
            ]);
        }
    };
    
    var viewModel = {
        schedulerOptions: schedulerOptions,
        getMovieById: getMovieById
    };
    
    ko.applyBindings(viewModel, document.getElementById("scheduler-demo"));
    
    function getMovieById(id) {
        return DevExpress.data.query(moviesData)
                .filter("id", id)
                .toArray()[0];
    }
};