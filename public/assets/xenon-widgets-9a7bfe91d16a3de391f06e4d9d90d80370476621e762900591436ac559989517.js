!function(c,f){"use strict";c(document).ready(function(){c(".page-loading-overlay").length?c(f).on("load",function(){setTimeout(t,200)}):t()});var t=function(){c("[data-from][data-to]").each(function(t,e){var u=c(e),f=scrollMonitor.create(e);f.fullyEnterViewport(function(){var t={useEasing:attrDefault(u,"easing",!0),useGrouping:attrDefault(u,"grouping",!0),separator:attrDefault(u,"separator",","),decimal:attrDefault(u,"decimal","."),prefix:attrDefault(u,"prefix",""),suffix:attrDefault(u,"suffix","")},e="this"==attrDefault(u,"count","this")?u:u.find(u.data("count")),a=attrDefault(u,"from",0),n=attrDefault(u,"to",100),r=attrDefault(u,"duration",2.5),o=attrDefault(u,"delay",0),i=new String(n).match(/\.([0-9]+)/)?new String(n).match(/\.([0-9]+)$/)[1].length:0,l=new countUp(e.get(0),a,n,i,r,t);setTimeout(function(){l.start()},1e3*o),f.destroy()})}),c("[data-fill-from][data-fill-to]").each(function(t,e){var r=c(e),o=scrollMonitor.create(e);o.fullyEnterViewport(function(){var t={current:null,from:attrDefault(r,"fill-from",0),to:attrDefault(r,"fill-to",100),property:attrDefault(r,"fill-property","width"),unit:attrDefault(r,"fill-unit","%")},e={current:t.to,onUpdate:function(){r.css(t.property,t.current+t.unit)},delay:attrDefault(r,"delay",0)},a=attrDefault(r,"fill-easing",!0),n=attrDefault(r,"fill-duration",2.5);a&&(e.ease=Sine.easeOut),t.current=t.from,TweenMax.to(t,n,e),o.destroy()})}),c(".xe-todo-list").on("change",'input[type="checkbox"]',function(){var t=c(this),e=t.closest("li");e.removeClass("done"),t.is(":checked")&&e.addClass("done")}),c(".xe-status-update").each(function(t,e){function a(t){(i=(i+t)%o.length)<0&&(i=o.length-1);var e=o.filter(".active"),a=o.eq(i);e.removeClass("active"),a.addClass("active").fadeTo(0,0).fadeTo(320,1)}var n=c(e),r=n.find(".xe-nav a"),o=n.find(".xe-body li"),i=o.filter(".active").index(),l=attrDefault(n,"auto-switch",0),u=0;0<l&&(u=setInterval(function(){a(1)},1e3*l),n.hover(function(){f.clearInterval(u)},function(){u=setInterval(function(){a(1)},1e3*l)})),r.on("click",function(t){t.preventDefault(),a(c(this).hasClass("xe-prev")?-1:1)})})}}(jQuery,window);