window.onload = function() {
    var schedulerOptions = {
        dataSource: data,
        views: [{
            type: "month",
            name: "Auto Mode",
            maxAppointmentsPerCell: "auto"
        }, {
            type: "month",
            name: "Unlimited Mode",
            maxAppointmentsPerCell: "unlimited"
        }, {
            type: "month",
            name: "Numeric Mode",
            maxAppointmentsPerCell: 2
        }],
        currentView: "Auto Mode",
        dropDownAppointmentTemplate: 'appointment-template',
        appointmentTooltipTemplate: 'appointment-template',
        onAppointmentDeleted: function() {
        	$("#scheduler").dxScheduler("instance").hideAppointmentTooltip();
        },
        currentDate: new Date(2017, 4, 26),
        resources: [{
            fieldExpr: "roomId",
            dataSource: resourcesData,
            label: "Room"
        }],
        height: 650
    };
    
    var viewModel = {
        schedulerOptions: schedulerOptions,
        getAppointmentColor: getAppointmentColor
    };

    ko.applyBindings(viewModel, document.body);
    
    function getAppointmentColor(resourceId) {
        return DevExpress.data.query(resourcesData)
                .filter("id", resourceId)
                .toArray()[0].color;
    }
};