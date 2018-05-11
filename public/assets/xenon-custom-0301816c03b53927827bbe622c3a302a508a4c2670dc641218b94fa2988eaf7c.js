function setup_sidebar_menu(){if(public_vars.$sidebarMenu.length){var e=public_vars.$sidebarMenu.find("li:has(> ul)"),r=public_vars.$sidebarMenu.hasClass("toggle-others");e.filter(".active").addClass("expanded"),1200<$(window).width()&&$(window).width()<1680&&0==public_vars.$sidebarMenu.hasClass("collapsed")?$(window).on("resize",function(){1200<$(window).width()&&$(window).width()<1680&&(public_vars.$sidebarMenu.addClass("collapsed"),ps_destroy())}):is("largescreen")&&0==public_vars.$sidebarMenu.hasClass("collapsed")&&$(window).on("resize",function(){is("tabletscreen")?(public_vars.$sidebarMenu.addClass("collapsed"),ps_destroy()):is("largescreen")&&(public_vars.$sidebarMenu.removeClass("collapsed"),ps_init())}),e.each(function(e,t){var a=jQuery(t),n=a.children("a"),i=a.children("ul");a.addClass("has-sub"),n.on("click",function(e){e.preventDefault(),r&&sidebar_menu_close_items_siblings(a),a.hasClass("expanded")||a.hasClass("opened")?sidebar_menu_item_collapse(a,i):sidebar_menu_item_expand(a,i)})})}}function sidebar_menu_item_expand(n,e){if(!(n.data("is-busy")||n.parent(".main-menu").length&&public_vars.$sidebarMenu.hasClass("collapsed"))){n.addClass("expanded").data("is-busy",!0),e.show();var i=e.children(),t=e.outerHeight(),a=(jQuery(window).height(),n.outerHeight(),public_vars.$sidebarMenu.scrollTop());n.position().top,public_vars.$sidebarMenu.hasClass("fit-in-viewport");i.addClass("is-hidden"),e.height(0),TweenMax.to(e,sm_duration,{css:{height:t},onUpdate:ps_update,onComplete:function(){e.height("")}});var r=n.data("sub_i_1"),s=n.data("sub_i_2");window.clearTimeout(r),r=setTimeout(function(){i.each(function(e,t){jQuery(t).addClass("is-shown")});var e=sm_transition_delay*i.length,t=parseFloat(i.eq(0).css("transition-duration")),a=parseFloat(i.last().css("transition-delay"));t&&a&&(e=1e3*(t+a)),window.clearTimeout(s),s=setTimeout(function(){i.removeClass("is-hidden is-shown")},e),n.data("is-busy",!1)},0),n.data("sub_i_1",r),n.data("sub_i_2",s)}}function sidebar_menu_item_collapse(e,t){if(!e.data("is-busy")){var a=t.children();e.removeClass("expanded").data("is-busy",!0),a.addClass("hidden-item"),TweenMax.to(t,sm_duration,{css:{height:0},onUpdate:ps_update,onComplete:function(){e.data("is-busy",!1).removeClass("opened"),t.attr("style","").hide(),a.removeClass("hidden-item"),e.find("li.expanded ul").attr("style","").hide().parent().removeClass("expanded"),ps_update(!0)}})}}function sidebar_menu_close_items_siblings(e){e.siblings().not(e).filter(".expanded, .opened").each(function(e,t){var a=jQuery(t);sidebar_menu_item_collapse(a,a.children("ul"))})}function setup_horizontal_menu(){if(public_vars.$horizontalMenu.length){var s=public_vars.$horizontalMenu.find("li:has(> ul)"),o=public_vars.$horizontalMenu.hasClass("click-to-expand");o&&public_vars.$mainContent.add(public_vars.$sidebarMenu).on("click",function(){s.removeClass("hover")}),s.each(function(e,t){var a=jQuery(t),n=a.children("a"),i=a.children("ul"),r=a.parent().is(".navbar-nav");a.addClass("has-sub"),n.on("click",function(e){isxs()&&(e.preventDefault(),sidebar_menu_close_items_siblings(a),a.hasClass("expanded")||a.hasClass("opened")?sidebar_menu_item_collapse(a,i):sidebar_menu_item_expand(a,i))}),o?n.on("click",function(e){var n;(e.preventDefault(),isxs())||(r?(s.filter(function(e,t){return jQuery(t).parent().is(".navbar-nav")}).not(a).removeClass("hover"),a.toggleClass("hover")):0==a.hasClass("expanded")?(a.addClass("expanded"),i.addClass("is-visible"),n=i.outerHeight(),i.height(0),TweenLite.to(i,.15,{css:{height:n},ease:Sine.easeInOut,onComplete:function(){i.attr("style","")}}),a.siblings().find("> ul.is-visible").not(i).each(function(e,t){var a=jQuery(t);n=a.outerHeight(),a.removeClass("is-visible").height(n),a.parent().removeClass("expanded"),TweenLite.to(a,.15,{css:{height:0},onComplete:function(){a.attr("style","")}})})):(n=i.outerHeight(),a.removeClass("expanded"),i.removeClass("is-visible").height(n),TweenLite.to(i,.15,{css:{height:0},onComplete:function(){i.attr("style","")}})))}):a.hoverIntent({over:function(){isxs()||(r?a.addClass("hover"):(i.addClass("is-visible"),sub_height=i.outerHeight(),i.height(0),TweenLite.to(i,.25,{css:{height:sub_height},ease:Sine.easeInOut,onComplete:function(){i.attr("style","")}})))},out:function(){isxs()||(r?a.removeClass("hover"):(sub_height=i.outerHeight(),a.removeClass("expanded"),i.removeClass("is-visible").height(sub_height),TweenLite.to(i,.25,{css:{height:0},onComplete:function(){i.attr("style","")}})))},timeout:200,interval:r?10:100})})}}function stickFooterToBottom(){if(public_vars.$mainFooter.add(public_vars.$mainContent).add(public_vars.$sidebarMenu).attr("style",""),isxs())return!1;if(public_vars.$mainFooter.hasClass("sticky")){var e=jQuery(window).height(),t=public_vars.$mainFooter.outerHeight(!0),a=public_vars.$mainFooter.position().top+t,n=public_vars.$horizontalNavbar.outerHeight();e>a-parseInt(public_vars.$mainFooter.css("marginTop"),10)&&public_vars.$mainFooter.css({marginTop:e-a-n})}}function ps_update(e){if(!isxs()&&jQuery.isFunction(jQuery.fn.perfectScrollbar)){if(public_vars.$sidebarMenu.hasClass("collapsed"))return;public_vars.$sidebarMenu.find(".sidebar-menu-inner").perfectScrollbar("update"),e&&(ps_destroy(),ps_init())}}function ps_init(){if(!isxs()&&jQuery.isFunction(jQuery.fn.perfectScrollbar)){if(public_vars.$sidebarMenu.hasClass("collapsed")||!public_vars.$sidebarMenu.hasClass("fixed"))return;public_vars.$sidebarMenu.find(".sidebar-menu-inner").perfectScrollbar({wheelSpeed:1,wheelPropagation:public_vars.wheelPropagation})}}function ps_destroy(){jQuery.isFunction(jQuery.fn.perfectScrollbar)&&public_vars.$sidebarMenu.find(".sidebar-menu-inner").perfectScrollbar("destroy")}function cbr_replace(){var e=jQuery('input[type="checkbox"].cbr, input[type="radio"].cbr').filter(":not(.cbr-done)"),l='<div class="cbr-replaced"><div class="cbr-input"></div><div class="cbr-state"><span></span></div></div>';e.each(function(e,t){var n=jQuery(t),a=n.is(":radio"),i=n.is(":checkbox"),r=n.is(":disabled"),s=["primary","secondary","success","danger","warning","info","purple","blue","red","gray","pink","yellow","orange","turquoise"];if(a||i){n.after(l),n.addClass("cbr-done");var o=n.next();o.find(".cbr-input").append(n),a&&o.addClass("cbr-radio"),r&&o.addClass("cbr-disabled"),n.is(":checked")&&o.addClass("cbr-checked"),jQuery.each(s,function(e,t){var a="cbr-"+t;n.hasClass(a)&&(o.addClass(a),n.removeClass(a))}),o.on("click",function(e){a&&n.prop("checked")||o.parent().is("label")||0==jQuery(e.target).is(n)&&(n.prop("checked",!n.is(":checked")),n.trigger("change"))}),n.on("change",function(){o.removeClass("cbr-checked"),n.is(":checked")&&o.addClass("cbr-checked"),cbr_recheck()})}})}function cbr_recheck(){jQuery("input.cbr-done").each(function(e,t){var a=jQuery(t),n=a.is(":radio"),i=(a.is(":checkbox"),a.is(":disabled")),r=a.closest(".cbr-replaced");i&&r.addClass("cbr-disabled"),n&&!a.prop("checked")&&r.hasClass("cbr-checked")&&r.removeClass("cbr-checked")})}function attrDefault(e,t,a){return void 0!==e.data(t)?e.data(t):a}function callback_test(){alert("Callback function executed! No. of arguments: "+arguments.length+"\n\nSee console log for outputed of the arguments."),console.log(arguments)}function date(e,t){var n,a,i=["Sun","Mon","Tues","Wednes","Thurs","Fri","Satur","January","February","March","April","May","June","July","August","September","October","November","December"],r=/\\?(.?)/gi,s=function(e,t){return a[e]?a[e]():t},o=function(e,t){for(e=String(e);e.length<t;)e="0"+e;return e};return a={d:function(){return o(a.j(),2)},D:function(){return a.l().slice(0,3)},j:function(){return n.getDate()},l:function(){return i[a.w()]+"day"},N:function(){return a.w()||7},S:function(){var e=a.j(),t=e%10;return t<=3&&1==parseInt(e%100/10,10)&&(t=0),["st","nd","rd"][t-1]||"th"},w:function(){return n.getDay()},z:function(){var e=new Date(a.Y(),a.n()-1,a.j()),t=new Date(a.Y(),0,1);return Math.round((e-t)/864e5)},W:function(){var e=new Date(a.Y(),a.n()-1,a.j()-a.N()+3),t=new Date(e.getFullYear(),0,4);return o(1+Math.round((e-t)/864e5/7),2)},F:function(){return i[6+a.n()]},m:function(){return o(a.n(),2)},M:function(){return a.F().slice(0,3)},n:function(){return n.getMonth()+1},t:function(){return new Date(a.Y(),a.n(),0).getDate()},L:function(){var e=a.Y();return e%4==0&e%100!=0|e%400==0},o:function(){var e=a.n(),t=a.W();return a.Y()+(12===e&&t<9?1:1===e&&9<t?-1:0)},Y:function(){return n.getFullYear()},y:function(){return a.Y().toString().slice(-2)},a:function(){return 11<n.getHours()?"pm":"am"},A:function(){return a.a().toUpperCase()},B:function(){var e=3600*n.getUTCHours(),t=60*n.getUTCMinutes(),a=n.getUTCSeconds();return o(Math.floor((e+t+a+3600)/86.4)%1e3,3)},g:function(){return a.G()%12||12},G:function(){return n.getHours()},h:function(){return o(a.g(),2)},H:function(){return o(a.G(),2)},i:function(){return o(n.getMinutes(),2)},s:function(){return o(n.getSeconds(),2)},u:function(){return o(1e3*n.getMilliseconds(),6)},e:function(){throw"Not supported (see source code of date() for timezone on how to add support)"},I:function(){return new Date(a.Y(),0)-Date.UTC(a.Y(),0)!=new Date(a.Y(),6)-Date.UTC(a.Y(),6)?1:0},O:function(){var e=n.getTimezoneOffset(),t=Math.abs(e);return(0<e?"-":"+")+o(100*Math.floor(t/60)+t%60,4)},P:function(){var e=a.O();return e.substr(0,3)+":"+e.substr(3,2)},T:function(){return"UTC"},Z:function(){return 60*-n.getTimezoneOffset()},c:function(){return"Y-m-d\\TH:i:sP".replace(r,s)},r:function(){return"D, d M Y H:i:s O".replace(r,s)},U:function(){return n/1e3|0}},this.date=function(e,t){return this,n=t===undefined?new Date:t instanceof Date?new Date(t):new Date(1e3*t),e.replace(r,s)},this.date(e,t)}var public_vars=public_vars||{};!function(_,n){"use strict";_(document).ready(function(){if(public_vars.$body=_("body"),public_vars.$pageContainer=public_vars.$body.find(".page-container"),public_vars.$chat=public_vars.$pageContainer.find("#chat"),public_vars.$sidebarMenu=public_vars.$pageContainer.find(".sidebar-menu"),public_vars.$sidebarProfile=public_vars.$sidebarMenu.find(".sidebar-user-info"),public_vars.$mainMenu=public_vars.$sidebarMenu.find(".main-menu"),public_vars.$horizontalNavbar=public_vars.$body.find(".navbar.horizontal-menu"),public_vars.$horizontalMenu=public_vars.$horizontalNavbar.find(".navbar-nav"),public_vars.$mainContent=public_vars.$pageContainer.find(".main-content"),public_vars.$mainFooter=public_vars.$body.find("footer.main-footer"),public_vars.$userInfoMenuHor=public_vars.$body.find(".navbar.horizontal-menu"),public_vars.$userInfoMenu=public_vars.$body.find("nav.navbar.user-info-navbar"),public_vars.$settingsPane=public_vars.$body.find(".settings-pane"),public_vars.$settingsPaneIn=public_vars.$settingsPane.find(".settings-pane-inner"),public_vars.wheelPropagation=!0,public_vars.$pageLoadingOverlay=public_vars.$body.find(".page-loading-overlay"),public_vars.defaultColorsPalette=["#68b828","#7c38bc","#0e62c7","#fcd036","#4fcdfc","#00b19d","#ff6264","#f7aa47"],public_vars.$pageLoadingOverlay.length&&_(n).load(function(){public_vars.$pageLoadingOverlay.addClass("loaded")}),n.onerror=function(){public_vars.$pageLoadingOverlay.addClass("loaded")},setup_sidebar_menu(),setup_horizontal_menu(),public_vars.$mainFooter.hasClass("sticky")&&(stickFooterToBottom(),_(n).on("xenon.resized",stickFooterToBottom)),_.isFunction(_.fn.perfectScrollbar)){public_vars.$sidebarMenu.hasClass("fixed")&&ps_init(),_(".ps-scrollbar").each(function(e,t){var a=_(t);a.hasClass("ps-scroll-down")&&a.scrollTop(a.prop("scrollHeight")),a.perfectScrollbar({wheelPropagation:!1})});var e=public_vars.$pageContainer.find("#chat .chat-inner");e.parent().hasClass("fixed")&&e.css({maxHeight:_(n).height()}).perfectScrollbar(),_(".dropdown:has(.ps-scrollbar)").each(function(){var t=_(this).find(".ps-scrollbar");_(this).on("click",'[data-toggle="dropdown"]',function(e){e.preventDefault(),setTimeout(function(){t.perfectScrollbar("update")},1)})}),_("div.scrollable").each(function(e,t){var a=_(t),n=parseInt(attrDefault(a,"max-height",200),10);n=n<0?200:n,a.css({maxHeight:n}).perfectScrollbar({wheelPropagation:!0})})}if(_(".user-info-menu .search-form, .nav.navbar-right .search-form").each(function(e,t){var a=_(t).find(".form-control");_(t).on("click",".btn",function(){if(0==a.val().trim().length)return jQuery(t).addClass("focused"),setTimeout(function(){a.focus()},100),!1}),a.on("blur",function(){jQuery(t).removeClass("focused")})}),public_vars.$mainFooter.hasClass("fixed")&&public_vars.$mainContent.css({paddingBottom:public_vars.$mainFooter.outerHeight(!0)}),_("body").on("click",'a[rel="go-top"]',function(e){e.preventDefault();var t={pos:_(n).scrollTop()};TweenLite.to(t,.3,{pos:0,ease:Power4.easeOut,onUpdate:function(){_(n).scrollTop(t.pos)}})}),public_vars.$userInfoMenu.length&&public_vars.$userInfoMenu.find(".user-info-menu > li").css({minHeight:public_vars.$userInfoMenu.outerHeight()-1}),_.isFunction(_.fn.autosize)&&_(".autosize, .autogrow").autosize(),cbr_replace(),_(".breadcrumb.auto-hidden").each(function(e,t){var a=_(t).find("li a"),n=(a.width(),0);a.each(function(e,t){var a=_(t);n=a.outerWidth(!0)+5,a.addClass("collapsed").width(n),a.hover(function(){a.removeClass("collapsed")},function(){a.addClass("collapsed")})})}),_(n).on("keydown",function(e){27==e.keyCode&&public_vars.$body.hasClass("modal-open")&&_(".modal-open .modal:visible").modal("hide")}),_(".input-group.input-group-minimal:has(.form-control)").each(function(e,t){var a=_(t);a.find(".form-control").on("focus",function(){a.addClass("focused")}).on("blur",function(){a.removeClass("focused")})}),_(".input-group.spinner").each(function(e,t){var a=_(t),n=a.find('[data-type="decrement"]'),i=a.find('[data-type="increment"]'),r=a.find(".form-control"),s=attrDefault(a,"step",1),o=attrDefault(a,"min",0),l=attrDefault(a,"max",0),c=o<l;n.on("click",function(e){e.preventDefault();var t=new Number(r.val())-s;c&&t<=o&&(t=o),r.val(t)}),i.on("click",function(e){e.preventDefault();var t=new Number(r.val())+s;c&&l<=t&&(t=l),r.val(t)})}),_.isFunction(_.fn.select2)&&(_(".select2").each(function(e,t){var a=_(t),n={allowClear:attrDefault(a,"allowClear",!1)};a.select2(n),a.addClass("visible")}),_.isFunction(_.fn.niceScroll)&&_(".select2-results").niceScroll({cursorcolor:"#d4d4d4",cursorborder:"1px solid #ccc",railpadding:{right:3}})),_.isFunction(_.fn.selectBoxIt)&&_("select.selectboxit").each(function(e,t){var a=_(t),n={showFirstOption:attrDefault(a,"first-option",!0),"native":attrDefault(a,"native",!1),defaultText:attrDefault(a,"text","")};a.addClass("visible"),a.selectBoxIt(n)}),_.isFunction(_.fn.datepicker)&&_(".datepicker").each(function(e,t){var a=_(t),n={format:attrDefault(a,"format","mm/dd/yyyy"),startDate:attrDefault(a,"startDate",""),endDate:attrDefault(a,"endDate",""),daysOfWeekDisabled:attrDefault(a,"disabledDays",""),startView:attrDefault(a,"startView",0),rtl:rtl()},i=a.next(),r=a.prev();a.datepicker(n),i.is(".input-group-addon")&&i.has("a")&&i.on("click",function(e){e.preventDefault(),a.datepicker("show")}),r.is(".input-group-addon")&&r.has("a")&&r.on("click",function(e){e.preventDefault(),a.datepicker("show")})}),_.isFunction(_.fn.daterangepicker)&&_(".daterange").each(function(e,t){var a={Today:[moment(),moment()],Yesterday:[moment().subtract("days",1),moment().subtract("days",1)],"Last 7 Days":[moment().subtract("days",6),moment()],"Last 30 Days":[moment().subtract("days",29),moment()],"This Month":[moment().startOf("month"),moment().endOf("month")],"Last Month":[moment().subtract("month",1).startOf("month"),moment().subtract("month",1).endOf("month")]},n=_(t),i={format:attrDefault(n,"format","MM/DD/YYYY"),timePicker:attrDefault(n,"timePicker",!1),timePickerIncrement:attrDefault(n,"timePickerIncrement",!1),separator:attrDefault(n,"separator"," - ")},r=attrDefault(n,"minDate",""),s=attrDefault(n,"maxDate",""),o=attrDefault(n,"startDate",""),l=attrDefault(n,"endDate","");n.hasClass("add-ranges")&&(i.ranges=a),r.length&&(i.minDate=r),s.length&&(i.maxDate=s),o.length&&(i.startDate=o),l.length&&(i.endDate=l),n.daterangepicker(i,function(e,t){var a=n.data("daterangepicker");n.is("[data-callback]")&&callback_test(e,t),n.hasClass("daterange-inline")&&n.find("span").html(e.format(a.format)+a.separator+t.format(a.format))}),"object"==typeof i.ranges&&n.data("daterangepicker").container.removeClass("show-calendar")}),_.isFunction(_.fn.timepicker)&&_(".timepicker").each(function(e,t){var a=_(t),n={template:attrDefault(a,"template",!1),showSeconds:attrDefault(a,"showSeconds",!1),defaultTime:attrDefault(a,"defaultTime","current"),showMeridian:attrDefault(a,"showMeridian",!0),minuteStep:attrDefault(a,"minuteStep",15),secondStep:attrDefault(a,"secondStep",15)},i=a.next(),r=a.prev();a.timepicker(n),i.is(".input-group-addon")&&i.has("a")&&i.on("click",function(e){e.preventDefault(),a.timepicker("showWidget")}),r.is(".input-group-addon")&&r.has("a")&&r.on("click",function(e){e.preventDefault(),a.timepicker("showWidget")})}),_.isFunction(_.fn.colorpicker)&&_(".colorpicker").each(function(e,t){var a=_(t),n={},i=a.next(),r=a.prev(),s=a.siblings(".input-group-addon").find(".color-preview");a.colorpicker(n),i.is(".input-group-addon")&&i.has("a")&&i.on("click",function(e){e.preventDefault(),a.colorpicker("show")}),r.is(".input-group-addon")&&r.has("a")&&r.on("click",function(e){e.preventDefault(),a.colorpicker("show")}),s.length&&(a.on("changeColor",function(e){s.css("background-color",e.color.toHex())}),a.val().length&&s.css("background-color",a.val()))}),_.isFunction(_.fn.validate)&&_("form.validate").each(function(e,t){var a=_(t),c={rules:{},messages:{},errorElement:"span",errorClass:"validate-has-error",highlight:function(e){_(e).closest(".form-group").addClass("validate-has-error")},unhighlight:function(e){_(e).closest(".form-group").removeClass("validate-has-error")},errorPlacement:function(e,t){t.closest(".has-switch").length?e.insertAfter(t.closest(".has-switch")):t.parent(".checkbox, .radio").length||t.parent(".input-group").length?e.insertAfter(t.parent()):e.insertAfter(t)}};a.find("[data-validate]").each(function(e,t){var a=_(t),n=a.attr("name"),i=attrDefault(a,"validate","").toString().split(",");for(var r in i){var s,o,l=i[r];"undefined"==typeof c.rules[n]&&(c.rules[n]={},c.messages[n]={}),-1!=_.inArray(l,["required","url","email","number","date","creditcard"])?(c.rules[n][l]=!0,(o=a.data("message-"+l))&&(c.messages[n][l]=o)):(s=l.match(/(\w+)\[(.*?)\]/i))&&-1!=_.inArray(s[1],["min","max","minlength","maxlength","equalTo"])&&(c.rules[n][s[1]]=s[2],(o=a.data("message-"+s[1]))&&(c.messages[n][s[1]]=o))}}),a.validate(c)}),_.isFunction(_.fn.inputmask)&&_("[data-mask]").each(function(e,t){var a=_(t),n=a.data("mask").toString(),i={numericInput:attrDefault(a,"numeric",!1),radixPoint:attrDefault(a,"radixPoint",""),rightAlign:"right"==attrDefault(a,"numericAlign","left")},r=attrDefault(a,"placeholder",""),s=attrDefault(a,"isRegex","");switch(r.length&&(i[r]=r),n.toLowerCase()){case"phone":n="(999) 999-9999";break;case"currency":case"rcurrency":var o=attrDefault(a,"sign","$");n="999,999,999.99","rcurrency"==a.data("mask").toLowerCase()?n+=" "+o:n=o+" "+n,i.numericInput=!0,i.rightAlignNumerics=!1,i.radixPoint=".";break;case"email":n="Regex",i.regex="[a-zA-Z0-9._%-]+@[a-zA-Z0-9-]+\\.[a-zA-Z]{2,4}";break;case"fdecimal":n="decimal",_.extend(i,{autoGroup:!0,groupSize:3,radixPoint:attrDefault(a,"rad","."),groupSeparator:attrDefault(a,"dec",",")})}s&&(i.regex=n,n="Regex"),a.inputmask(n,i)}),_.isFunction(_.fn.bootstrapWizard)&&_(".form-wizard").each(function(e,t){var a=_(t),i=a.find("> .tabs > li"),r=a.find(".progress-indicator"),n=a.find("> ul > li.active").index(),s=function(){if(a.hasClass("validate")&&!a.valid())return a.data("validator").focusInvalid(),!1;return!0};0<n&&(r.css({width:n/i.length*100+"%"}),i.removeClass("completed").slice(0,n).addClass("completed")),a.bootstrapWizard({tabClass:"",onTabShow:function(e,t,a){var n=i.eq(a).position().left/i.parent().width()*100;i.removeClass("completed").slice(0,a).addClass("completed"),r.css({width:n+"%"})},onNext:s,onTabClick:s}),a.data("bootstrapWizard").show(n),a.find(".pager a").on("click",function(e){e.preventDefault()})}),_.isFunction(_.fn.slider)&&_(".slider").each(function(e,t){var a=_(t),i=_('<span class="ui-label"></span>'),r=i.clone(),n=0!=attrDefault(a,"vertical",0)?"vertical":"horizontal",s=attrDefault(a,"prefix",""),o=attrDefault(a,"postfix",""),l=attrDefault(a,"fill",""),c=_(l),u=attrDefault(a,"step",1),d=attrDefault(a,"value",5),f=attrDefault(a,"min",0),h=attrDefault(a,"max",100),p=attrDefault(a,"min-val",10),v=attrDefault(a,"max-val",90),b=a.is("[data-min-val]")||a.is("[data-max-val]"),m=0;if(b){a.slider({range:!0,orientation:n,min:f,max:h,values:[p,v],step:u,slide:function(e,t){var a=(s||"")+t.values[0]+(o||""),n=(s||"")+t.values[1]+(o||"");i.html(a),r.html(n),l&&c.val(a+","+n),m++},change:function(e,t){if(1==m){var a=(s||"")+t.values[0]+(o||""),n=(s||"")+t.values[1]+(o||"");i.html(a),r.html(n),l&&c.val(a+","+n)}m=0}});var g=a.find(".ui-slider-handle");i.html((s||"")+p+(o||"")),g.first().append(i),r.html((s||"")+v+(o||"")),g.last().append(r)}else{a.slider({range:!attrDefault(a,"basic",0)&&"min",orientation:n,min:f,max:h,value:d,step:u,slide:function(e,t){var a=(s||"")+t.value+(o||"");i.html(a),l&&c.val(a),m++},change:function(e,t){if(1==m){var a=(s||"")+t.value+(o||"");i.html(a),l&&c.val(a)}m=0}});g=a.find(".ui-slider-handle");i.html((s||"")+d+(o||"")),g.html(i)}}),_.isFunction(_.fn.knob)&&_(".knob").knob({change:function(){},release:function(){},cancel:function(){},draw:function(){if("tron"==this.$.data("skin")){var e,t=this.angle(this.cv),a=this.startAngle,n=this.startAngle,i=n+t,r=1;return this.g.lineWidth=this.lineWidth,this.o.cursor&&(n=i-.3)&&(i+=.3),this.o.displayPrevious&&(e=this.startAngle+this.angle(this.v),this.o.cursor&&(a=e-.3)&&(e+=.3),this.g.beginPath(),this.g.strokeStyle=this.pColor,this.g.arc(this.xy,this.xy,this.radius-this.lineWidth,a,e,!1),this.g.stroke()),this.g.beginPath(),this.g.strokeStyle=r?this.o.fgColor:this.fgColor,this.g.arc(this.xy,this.xy,this.radius-this.lineWidth,n,i,!1),this.g.stroke(),this.g.lineWidth=2,this.g.beginPath(),this.g.strokeStyle=this.o.fgColor,this.g.arc(this.xy,this.xy,this.radius-this.lineWidth+1+2*this.lineWidth/3,0,2*Math.PI,!1),this.g.stroke(),!1}}}),_.isFunction(_.fn.wysihtml5)&&_(".wysihtml5").each(function(e,t){var a=_(t),n=attrDefault(a,"stylesheet-url","");_(".wysihtml5").wysihtml5({size:"white",stylesheets:n.split(","),html:attrDefault(a,"html",!0),color:attrDefault(a,"colors",!0)})}),_.isFunction(_.fn.ckeditor)&&_(".ckeditor").ckeditor({contentsLangDirection:rtl()?"rtl":"ltr"}),"undefined"!=typeof Dropzone&&(Dropzone.autoDiscover=!1,_(".dropzone[action]").each(function(e,t){_(t).dropzone()})),_.isFunction(_.fn.tocify)&&_("#toc").length){_("#toc").tocify({context:".tocify-content",selectors:"h2,h3,h4,h5"});var t=_(".tocify"),a=scrollMonitor.create(t.get(0));t.width(t.parent().width()),a.lock(),a.stateChange(function(){_(t.get(0)).toggleClass("fixed",this.isAboveViewport)})}_(".login-form .form-group:has(label)").each(function(e,t){var a=_(t),n=a.find("label"),i=a.find(".form-control");i.on("focus",function(){a.addClass("is-focused")}),i.on("keydown",function(){a.addClass("is-focused")}),i.on("blur",function(){a.removeClass("is-focused"),0<i.val().trim().length&&a.addClass("is-focused")}),n.on("click",function(){i.focus()}),0<i.val().trim().length&&a.addClass("is-focused")})});var e=0;_(n).resize(function(){clearTimeout(e),e=setTimeout(trigger_resizable,200)})}(jQuery,window);var sm_duration=.2,sm_transition_delay=150;