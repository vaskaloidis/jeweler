(function(DX, undefined) {
    "use strict";

    function renderBasicTypographyContent() {
        return [
            $("<h1 />").text("h1 heading"),
            $("<h2 />").text("h2 heading"),
            $("<h3 />").text("h3 heading"),
            $("<h4 />").text("h4 heading"),
            $("<h5 />").text("h5 heading"),
            $("<h6 />").text("h6 heading"),
            $("<a />").text("Hyperlink").attr("href", "#").css("display", "block")
        ];
    }

    window.SHOW_ACTIONSHEET = function() {
        $(".dx-actionsheet").dxActionSheet("instance").show();
    };

    window.SHOW_DROPDOWN_MENU = function() {
        $(".dx-dropdownmenu").dxDropDownMenu("instance").option("visible", true);
    };

    window.SHOW_LOAD_PANEL = function() {
        $("#load-panel-sample").dxLoadPanel("instance").option("visible", true);
    };

    window.SHOW_DATE_PICKER = function() {
        $("#date-picker-sample").dxDatePicker("instance").option("visible", true);
    };

    window.SHOW_INFO_TOAST = function() {
        $("#info-toast-sample").dxToast("instance").show();
    };

    window.SHOW_WARNING_TOAST = function() {
        $("#warning-toast-sample").dxToast("instance").show();
    };

    window.SHOW_ERROR_TOAST = function() {
        $("#error-toast-sample").dxToast("instance").show();
    };

    window.SHOW_SUCCESS_TOAST = function() {
        $("#success-toast-sample").dxToast("instance").show();
    };

    window.SHOW_CUSTOM_TOAST = function() {
        $("#custom-toast-sample").dxToast("instance").show();
    };

    window.SHOW_POPUP = function() {
        $("#popup-sample .dx-popup-content").html("<p>The popup contents.</p>");
        $("#popup-sample").dxPopup("instance").option("visible", true);
    };

    window.SHOW_TOOLTIP = function() {
        $("#tooltip-sample .dx-popup-content").html("<p>The tooltip contents.</p>");
        $("#tooltip-sample").dxTooltip("instance").option("visible", true);
    };

    window.SHOW_CONFIRM_DIALOG = function() {
        DX.ui.dialog.confirm("Are you sure?", "Confirm changes");
    };

    window.LOAD_SCROLLVIEW_CONTENT = function($widgetNode, options) {
        $widgetNode.append("<p>Chuck ex ea, aliqua ball tip tail hamburger ham.  Tri-tip cow nulla jerky, exercitation aute commodo ut adipisicing officia flank brisket non prosciutto rump.  Eu fugiat sint, incididunt consectetur velit turducken sausage boudin consequat hamburger corned beef ham hock shoulder.  Biltong frankfurter enim, shankle pork loin ex dolor venison pastrami ground round tenderloin cillum chuck magna.  Doner capicola cillum corned beef aliquip, et leberkas shoulder exercitation.  Nostrud ut reprehenderit drumstick labore kevin ball tip doner enim sint ea t-bone.  Pig velit enim, ball tip reprehenderit pork loin pork belly irure in do magna prosciutto et aute minim.</p>")
         .append("<p>T-bone est meatloaf magna sausage kielbasa non spare ribs veniam nostrud ad proident beef turducken cupidatat.  Quis ribeye sunt, eiusmod jowl ut pariatur irure meatloaf cupidatat hamburger.  T-bone pancetta pastrami eiusmod bresaola minim capicola quis pork loin beef ribs.  Dolore salami bacon nostrud ad bresaola eu, ullamco id chuck anim mollit pork belly.  Meatball flank short loin, ball tip laborum cow porchetta sirloin non ullamco ex swine tempor.</p>")
        .append("<p>Magna drumstick boudin exercitation.  Deserunt dolore doner pork loin meatloaf sausage.  Venison cupidatat quis nisi pork tail chuck.  Ribeye duis bacon commodo eu salami, deserunt occaecat.  Beef consequat fatback landjaeger turkey, minim venison salami andouille adipisicing cow nisi doner shank.</p><p>Tail qui fatback excepteur magna pork chop kielbasa laboris duis labore tongue shank pork belly reprehenderit.  Occaecat chuck ad deserunt.  Flank jerky ad veniam, est pastrami cow doner cupidatat in dolor sausage.  Consectetur sirloin swine, voluptate anim mollit tongue boudin quis.  Sed beef ribs velit rump pariatur fatback duis cupidatat, in leberkas culpa occaecat pork belly cillum pork chop.  Boudin ground round capicola, tongue excepteur esse ad nulla.  Nostrud elit excepteur incididunt id turkey, jerky pastrami eiusmod.</p>")
        .append("<p>Fugiat pork belly pastrami ullamco enim cow kevin nulla voluptate in tempor prosciutto qui.  Shoulder sed officia shankle consequat.  Pork belly aute eu beef ribs nulla.  Labore consequat voluptate pig, turducken proident nisi rump et tail non in.  Frankfurter fugiat cow esse.  Aliqua adipisicing occaecat in deserunt, pig tri-tip ullamco irure.  Boudin in cow, nisi fugiat beef biltong pariatur sunt jerky anim.</p>")
        .append("<p>Sirloin pork est jerky.  Pork loin pork belly shank, beef ribs tail porchetta ribeye ground round filet mignon ut officia.  Id aliquip enim, leberkas chicken exercitation dolore sunt venison.  Magna ground round incididunt voluptate, t-bone sunt tempor pariatur ham boudin venison anim drumstick.  Jowl dolor kielbasa, eiusmod chuck pork belly t-bone ad boudin andouille ham hock shank.  Pork andouille chuck nulla drumstick magna.</p>")
        .append("<p>Anim quis strip steak turkey dolor ex occaecat leberkas culpa.  Nostrud ex occaecat strip steak sed.  Drumstick labore ham laborum.  Sirloin deserunt excepteur shoulder esse.</p>")
        .height(300);

        options.pullDownAction = $.noop;
    };

    window.SET_CALENDAR_VALUE = function($widgetNode, options) {
        options.value = new Date(2014, 5, 2);
    };

    window.LOAD_GENERIC_TYPOGRAPHY_CONTENT = function($widgetNode) {
        $widgetNode.append(
            renderBasicTypographyContent().concat([
            $("<div />").addClass("dx-fieldset").append([
                $("<div />").addClass("dx-field")
                    .append([
                         $("<div />").addClass("dx-field-label").text("Fieldset label:").css("width", "20%"),
                         $("<div />").addClass("dx-field-value-static").text("Fieldset value").css("width", "80%")
                    ]),
                $("<div />").addClass("dx-field icons-preview")
                    .append([
                            $("<div />").addClass("dx-field-label").text("Icons:").css("width", "20%"),
                            $("<div />").addClass("dx-field-value-static").css("width", "80%").append([
                                $("<div />").dxButton({ icon: "car", text: "Car", width: 100 }),
                                $("<div />").dxButton({ icon: "gift", text: "Gift", width: 100 }),
                                $("<div />").dxButton({ icon: "cart", text: "Cart", width: 100 })
                            ])
                    ])
            ])
            ]));
    };

    window.LOAD_ANDROID5_TYPOGRAPHY_CONTENT = function($widgetNode) {
        $widgetNode.append(
            renderBasicTypographyContent().concat([
            $("<div />").addClass("dx-fieldset").append([
                $("<div />").addClass("dx-field")
                    .append([
                         $("<div />").addClass("dx-field-label").text("Fieldset label:").css("width", "20%"),
                         $("<div />").addClass("dx-field-value-static").text("Fieldset value").css("width", "80%")
                    ]),
                $("<div />").addClass("dx-field icons-preview")
                    .append([
                            $("<div />").addClass("dx-field-label").text("Dark Icons:").css("width", "20%"),
                            $("<div />").addClass("dx-field-value-static").css("width", "80%").append([
                                $("<div />").dxButton({ icon: "car", text: "Car", width: 100 }),
                                $("<div />").dxButton({ icon: "gift", text: "Gift", width: 100 }),
                                $("<div />").dxButton({ icon: "cart", text: "Cart", width: 100 })
                            ])
                    ]),
                $("<div />").addClass("dx-field icons-preview")
                    .append([
                            $("<div />").addClass("dx-field-label").text("Light Icons:").css("width", "20%"),
                            $("<div />").addClass("dx-field-value-static").css("width", "80%").append([
                                $("<div />").dxButton({ icon: "car", text: "Car", width: 100, type: "success" }),
                                $("<div />").dxButton({ icon: "gift", text: "Gift", width: 100, type: "success" }),
                                $("<div />").dxButton({ icon: "cart", text: "Cart", width: 100, type: "success" })
                            ])
                    ])
            ])
            ]));
    };

    window.LOAD_IOS7_TYPOGRAPHY_CONTENT = function($widgetNode) {
        $widgetNode.append(
            renderBasicTypographyContent().concat([
            $("<div />").addClass("dx-fieldset").append([
                $("<div />").addClass("dx-field")
                    .append([
                         $("<div />").addClass("dx-field-label").text("Fieldset label:"),
                         $("<div />").addClass("dx-field-value-static").text("Fieldset value")
                    ])
            ])
            ]));
    };

    window.MAKE_TREEVIEW_BORDER = function($widgetNode) {
        $widgetNode.addClass("dx-treeview-border-visible");
    };

    window.VALIDATION_ACTION = function($widgetNode, options) {
        $widgetNode.dxValidator(options.validationOptions);
        $widgetNode.dxValidator("instance").validate();
    };

    var transformClickAction = function(clickActionAsString) {
        if(typeof clickActionAsString === "function")
            return clickActionAsString;

        if(clickActionAsString && !window[clickActionAsString])
            throw new Error(clickActionAsString + " is not defined");

        return window[clickActionAsString];
    };

    var invokePrerenderAction = function(prerenderAction, $widgetNode, options) {
        if(window[prerenderAction])
            window[prerenderAction]($widgetNode, options);
    };

    var invokeAfterRenderAction = function(afterRenderAction, $widgetNode, options) {
        if(window[afterRenderAction])
            window[afterRenderAction]($widgetNode, options);
    };

    ko.bindingHandlers.preview = {
        update: function(element, valueAccessor, allBindings, viewModel, bindingContext) {
            renderCore({
                $element: $(element),
                values: valueAccessor(),
                theme: bindingContext.$root.theme(),
                contentUrl: bindingContext.$root.contentUrl
            });
        }
    };

    function getDeviceInfo(theme) {
        var deviceType = "desktop";

        switch(theme) {
            case "ios7":
                deviceType = "iPad";
                break;
            case "android5":
                deviceType = "androidTablet";
                break;
            case "generic":
                deviceType = "desktop";
                break;

            default: break;
        }

        return deviceType;
    }

    function renderCore(options) {
        if("widgets" in options.values.data)
            return renderWidgets(options);

        if("application" in options.values.data)
            return renderApplication(options);

        throw Error("Unknown type of preview item");
    }

    function renderWidgets(options) {
        var $element = options.$element,
            values = options.values,
            theme = options.theme;

        var data = values.data,
            id = data.id,
            group = data.name,
            widgets = data.widgets,
            useFieldset = data.useFieldset;

        function renderWidget($box, widget) {
            if(!$.isFunction($.fn[widget.name])) {
                throw new Error("Unable to render widget: " + widget.name);
            }

            var $widgetNode = $("<div />");

            if(useFieldset)
                $widgetNode.addClass("dx-field-value");

            if(widget.id)
                $widgetNode.attr("id", widget.id);

            $box.append($widgetNode);

            if(widget.options.click)
                widget.options.onClick = transformClickAction(widget.options.click);

            if(widget.prerenderAction)
                invokePrerenderAction(widget.prerenderAction, $widgetNode, widget.options);

            $widgetNode[widget.name](widget.options);

            if(widget.afterRenderAction)
                invokeAfterRenderAction(widget.afterRenderAction, $widgetNode, widget.options);
        }

        DX.devices.current(getDeviceInfo(theme));

        $element.addClass(id.toLowerCase().replace(/\s|\./g, "-") + "-group");

        if(useFieldset)
            $element.addClass("dx-fieldset");

        $.each(widgets, function(index, widgetOptions) {
            var $box = $("<div/>")
                .addClass("widget-box-".concat(index))
                .addClass(widgetOptions.name.toLowerCase().concat("-box"))
                .appendTo($element);

            if(widgetOptions.title) {
                if(useFieldset) {
                    $box.addClass("dx-field")
                        .append($("<div />")
                            .addClass("dx-field-label")
                            .text(widgetOptions.title)
                        );
                }
                else {
                    $("<h4/>").addClass("widget-title")
                        .text(widgetOptions.title)
                        .appendTo($box);
                }
            }

            renderWidget($box, widgetOptions);
        });
    }

    var store = new DX.data.ArrayStore({
        data: [
            {
                "id": 0,
                "name": "Russia",
                "capital": "Moscow",
                "formedAt": 862,
                "area": "17,098,242 km<sup>2<sup>",
                "population": "143,975,923",
                "currency": "Russian ruble (RUB)",
                "group": "Group A"
            },
            {
                "id": 1,
                "name": "Czech",
                "capital": "Prague",
                "formedAt": 870,
                "area": "78,866 km<sup>2<sup>",
                "population": "10,538,275",
                "currency": "Czech koruna (CZK)",
                "group": "Group A"
            },
            {
                "id": 2,
                "name": "Poland",
                "capital": "Warsaw",
                "formedAt": 870,
                "area": "312,679 km<sup>2<sup>",
                "population": "38,483,957",
                "currency": "Złoty (PLN)",
                "group": "Group A"
            },
            {
                "id": 3,
                "name": "Greece",
                "capital": "Athens",
                "formedAt": 1821,
                "area": "131,957 km<sup>2<sup>",
                "population": "10,816,286",
                "currency": "Euro (EUR)",
                "group": "Group B"
            },
            {
                "id": 4,
                "name": "Germany",
                "capital": "Berlin",
                "formedAt": 962,
                "area": "357,168 km<sup>2<sup>",
                "population": "80,716,000",
                "currency": "Euro (EUR)",
                "group": "Group B"
            },
            {
                "id": 5,
                "name": "Portugal",
                "capital": "Lisbon",
                "formedAt": 868,
                "area": "92,212 km<sup>2<sup>",
                "population": "10,427,301",
                "currency": "Euro (EUR)",
                "group": "Group B"
            },
            {
                "id": 6,
                "name": "Denmark",
                "capital": "Copenhagen",
                "formedAt": "10th century",
                "area": "42,915.7 km<sup>2<sup>",
                "population": "5,659,715",
                "currency": "Euro (EUR)",
                "group": "Group B"
            },
            {
                "id": 7,
                "name": "Netherlands",
                "capital": "Amsterdam",
                "formedAt": "26 July 1581",
                "area": "41,543 km<sup>2<sup>",
                "population": "16,912,640",
                "currency": "Euro (EUR)",
                "group": "Group B"
            }
        ],
        key: "id"
    });

    window.list = function(params) {
        return {
            dataSource: new DX.data.DataSource({
                store: store,
                group: { selector: "group", desc: false }
            }),
            selectedId: ko.observable(),
            navigateToDetails: function(id) {
                this.selectedId(id);

                dxApp.app.navigate({
                    view: 'details',
                    id: id
                }, { root: true });
            }
        };
    };

    window.details = function(params) {
        var viewModel = {
            id: ko.observable(),
            name: ko.observable(),
            area: ko.observable(),
            capital: ko.observable(),
            formedAt: ko.observable(),
            currency: ko.observable(),
            population: ko.observable()
        };

        if(!!params.id) {
            store.byKey(params.id || 1)
                .done(function(entity) {
                    viewModel.id(entity.id);
                    viewModel.name(entity.name);
                    viewModel.area(entity.area);
                    viewModel.capital(entity.capital);
                    viewModel.currency(entity.currency);
                    viewModel.formedAt(entity.formedAt);
                    viewModel.population(entity.population);
                });
        }

        return viewModel;
    };

    function renderApplication(options) {
        var q = DevExpress.createQueue();
        var $element = options.$element,
            values = options.values;

        var device,
            appOptions = values.data.application[0];

        window.dxApp = window.dxApp || {};

        device = getDeviceInfo(options.theme);
        if($.isPlainObject(appOptions.device))
            device = $.extend(device, appOptions.device);

        DX.devices.current(device);
        ko.utils.domNodeDisposal.addDisposeCallback(
            $element.get(0),
            function handleDispose() {
                DX.viewPort(document.body);
            }
        );

        dxApp.app = new DX.framework.html.HtmlApplication({
            rootNode: $element,

            layoutSet: $.map(appOptions.layoutSet, function(layoutInfo) {
                var controllerImpl = DX.data.utils.compileGetter(
                        layoutInfo.controllerExpr
                    )(window, { functionsAsIs: true });

                return {
                    platform: layoutInfo.platform,
                    controller: !layoutInfo.controllerOptions
                        ? new controllerImpl
                        : new controllerImpl(layoutInfo.controllerOptions)
                };
            }),

            navigation: appOptions.navigation
        });

        dxApp.app.router.register(":view/:id", {
            view: appOptions.startupView,
            id: undefined
        });

        $.each(appOptions.views, function(_, viewName) {
            dxApp.app.loadTemplates($($("#" + viewName + "-view").html()));
        });

        $.each(appOptions.layouts, function(_, layoutName) {
            q.add(function() {
                return $.Deferred(function(d) {

                    function handleFail() {
                        DevExpress.ui.notify("An error occurred. Please, refresh the page", "error", 4000);
                        d.reject.apply(d, arguments);
                    }

                    ThemeBuilder.LayoutsLoader.load(layoutName)
                        .done(function(layoutMarkup) {
                            dxApp.app.loadTemplates($(layoutMarkup))
                                .done(d.resolve)
                                .fail(handleFail);
                        })
                        .fail(handleFail);

                }).promise();
            });
        });

        q.add(function() {
            DevExpress.data.query($.makeArray(appOptions.startupView))
                .select(function(navTarget) {
                    dxApp.app.navigate(navTarget);
                })
                .toArray();
        });

        function contentUrl() {
            return options.contentUrl;
        }
    }
})(DevExpress);