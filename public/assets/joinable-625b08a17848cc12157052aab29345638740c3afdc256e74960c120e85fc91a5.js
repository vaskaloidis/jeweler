function countUp(t,e,o,n,i,r){for(var s=0,a=["webkit","moz","ms","o"],l=0;l<a.length&&!window.requestAnimationFrame;++l)window.requestAnimationFrame=window[a[l]+"RequestAnimationFrame"],window.cancelAnimationFrame=window[a[l]+"CancelAnimationFrame"]||window[a[l]+"CancelRequestAnimationFrame"];window.requestAnimationFrame||(window.requestAnimationFrame=function(t){var e=(new Date).getTime(),o=Math.max(0,16-(e-s)),n=window.setTimeout(function(){t(e+o)},o);return s=e+o,n}),window.cancelAnimationFrame||(window.cancelAnimationFrame=function(t){clearTimeout(t)}),this.options=r||{useEasing:!0,useGrouping:!0,separator:",",decimal:"."},""==this.options.separator&&(this.options.useGrouping=!1),null==this.options.prefix&&(this.options.prefix=""),null==this.options.suffix&&(this.options.suffix="");var c=this;this.d="string"==typeof t?document.getElementById(t):t,this.startVal=Number(e),this.endVal=Number(o),this.countDown=this.startVal>this.endVal,this.startTime=null,this.timestamp=null,this.remaining=null,this.frameVal=this.startVal,this.rAF=null,this.decimals=Math.max(0,n||0),this.dec=Math.pow(10,this.decimals),this.duration=1e3*i||2e3,this.version=function(){return"1.3.1"},this.printValue=function(t){var e=isNaN(t)?"--":c.formatNumber(t);"INPUT"==c.d.tagName?this.d.value=e:this.d.innerHTML=e},this.easeOutExpo=function(t,e,o,n){return 1024*o*(1-Math.pow(2,-10*t/n))/1023+e},this.count=function(t){null===c.startTime&&(c.startTime=t);var e=(c.timestamp=t)-c.startTime;if(c.remaining=c.duration-e,c.options.useEasing)if(c.countDown){var o=c.easeOutExpo(e,0,c.startVal-c.endVal,c.duration);c.frameVal=c.startVal-o}else c.frameVal=c.easeOutExpo(e,c.startVal,c.endVal-c.startVal,c.duration);else if(c.countDown){o=(c.startVal-c.endVal)*(e/c.duration);c.frameVal=c.startVal-o}else c.frameVal=c.startVal+(c.endVal-c.startVal)*(e/c.duration);c.frameVal=c.countDown?c.frameVal<c.endVal?c.endVal:c.frameVal:c.frameVal>c.endVal?c.endVal:c.frameVal,c.frameVal=Math.round(c.frameVal*c.dec)/c.dec,c.printValue(c.frameVal),e<c.duration?c.rAF=requestAnimationFrame(c.count):null!=c.callback&&c.callback()},this.start=function(t){return c.callback=t,isNaN(c.endVal)||isNaN(c.startVal)?(console.log("countUp error: startVal or endVal is not a number"),c.printValue()):c.rAF=requestAnimationFrame(c.count),!1},this.stop=function(){cancelAnimationFrame(c.rAF)},this.reset=function(){c.startTime=null,c.startVal=e,cancelAnimationFrame(c.rAF),c.printValue(c.startVal)},this.resume=function(){c.stop(),c.startTime=null,c.duration=c.remaining,c.startVal=c.frameVal,requestAnimationFrame(c.count)},this.formatNumber=function(t){var e,o,n,i;if(t=t.toFixed(c.decimals),o=(e=(t+="").split("."))[0],n=1<e.length?c.options.decimal+e[1]:"",i=/(\d+)(\d{3})/,c.options.useGrouping)for(;i.test(o);)o=o.replace(i,"$1"+c.options.separator+"$2");return c.options.prefix+o+n+c.options.suffix},c.printValue(c.startVal)}!function(m){var w,t={className:"autosizejs",id:"autosizejs",append:"\n",callback:!1,resizeDelay:10,placeholder:!0},g=["fontFamily","fontSize","fontWeight","fontStyle","letterSpacing","textTransform","wordSpacing","textIndent"],v=m('<textarea tabindex="-1" style="position:absolute; top:-999px; left:0; right:auto; bottom:auto; border:0; padding: 0; -moz-box-sizing:content-box; -webkit-box-sizing:content-box; box-sizing:content-box; word-wrap:break-word; height:0 !important; min-height:0 !important; overflow:hidden; transition:none; -webkit-transition:none; -moz-transition:none;"/>').data("autosize",!0)[0];(v.style.lineHeight="99px")===m(v).css("lineHeight")&&g.push("lineHeight"),v.style.lineHeight="",m.fn.autosize=function(f){return this.length?(f=m.extend({},t,f||{}),v.parentNode!==document.body&&m(document.body).append(v),this.each(function(){function n(){var o,n=!!window.getComputedStyle&&window.getComputedStyle(a,null);n?((0===(o=a.getBoundingClientRect().width)||"number"!=typeof o)&&(o=parseInt(n.width,10)),m.each(["paddingLeft","paddingRight","borderLeftWidth","borderRightWidth"],function(t,e){o-=parseInt(n[e],10)})):o=l.width(),v.style.width=Math.max(o,0)+"px"}function o(){var o={};if(w=a,v.className=f.className,v.id=f.id,i=parseInt(l.css("maxHeight"),10),m.each(g,function(t,e){o[e]=l.css(e)}),m(v).css(o).attr("wrap",l.attr("wrap")),n(),window.chrome){var t=a.style.width;a.style.width="0px",a.offsetWidth,a.style.width=t}}function e(){var t,e;w!==a?o():n(),v.value=!a.value&&f.placeholder?(l.attr("placeholder")||"")+f.append:a.value+f.append,v.style.overflowY=a.style.overflowY,e=parseInt(a.style.height,10),v.scrollTop=0,v.scrollTop=9e4,t=v.scrollTop,i&&i<t?(a.style.overflowY="scroll",t=i):(a.style.overflowY="hidden",t<r&&(t=r)),e!==(t+=c)&&(a.style.height=t+"px",u&&f.callback.call(a,a))}function t(){clearTimeout(s),s=setTimeout(function(){var t=l.width();t!==d&&(d=t,e())},parseInt(f.resizeDelay,10))}var i,r,s,a=this,l=m(a),c=0,u=m.isFunction(f.callback),p={height:a.style.height,overflow:a.style.overflow,overflowY:a.style.overflowY,wordWrap:a.style.wordWrap,resize:a.style.resize},d=l.width(),h=l.css("resize");l.data("autosize")||(l.data("autosize",!0),("border-box"===l.css("box-sizing")||"border-box"===l.css("-moz-box-sizing")||"border-box"===l.css("-webkit-box-sizing"))&&(c=l.outerHeight()-l.height()),r=Math.max(parseInt(l.css("minHeight"),10)-c||0,l.height()),l.css({overflow:"hidden",overflowY:"hidden",wordWrap:"break-word"}),"vertical"===h?l.css("resize","none"):"both"===h&&l.css("resize","horizontal"),"onpropertychange"in a?"oninput"in a?l.on("input.autosize keyup.autosize",e):l.on("propertychange.autosize",function(){"value"===event.propertyName&&e()}):l.on("input.autosize",e),!1!==f.resizeDelay&&m(window).on("resize.autosize",t),l.on("autosize.resize",e),l.on("autosize.resizeIncludeStyle",function(){w=null,e()}),l.on("autosize.destroy",function(){w=null,clearTimeout(s),m(window).off("resize",t),l.off("autosize").off(".autosize").css(p).removeData("autosize")}),e())})):this}}(window.jQuery||window.$),function(t){if("undefined"!=typeof define&&define.amd)define(["jquery"],t);else if("undefined"!=typeof module&&module.exports){var e=require("jquery");module.exports=t(e)}else window.scrollMonitor=t(jQuery)}(function(d){function t(){return window.innerHeight||document.documentElement.clientHeight}function e(){if(f.viewportTop=p.scrollTop(),f.viewportBottom=f.viewportTop+f.viewportHeight,f.documentHeight=m.height(),f.documentHeight!==a){for(l=w.length;l--;)w[l].recalculateLocation();a=f.documentHeight}}function o(){f.viewportHeight=t(),e(),i()}function n(){clearTimeout(c),c=setTimeout(o,100)}function i(){for(u=w.length;u--;)w[u].update();for(u=w.length;u--;)w[u].triggerCallbacks()}function r(t,e){function i(t){if(0!==t.length)for(a=t.length;a--;)(l=t[a]).callback.call(c,h),l.isOne&&t.splice(a,1)}var o,n,r,s,a,l,c=this;this.watchItem=t,this.offsets=e?e===+e?{top:e,bottom:e}:d.extend({},I,e):I,this.callbacks={};for(var u=0,p=T.length;u<p;u++)c.callbacks[T[u]]=[];this.locked=!1,this.triggerCallbacks=function(){switch(this.isInViewport&&!o&&i(this.callbacks[v]),this.isFullyInViewport&&!n&&i(this.callbacks[b]),this.isAboveViewport!==r&&this.isBelowViewport!==s&&(i(this.callbacks[g]),n||this.isFullyInViewport||(i(this.callbacks[b]),i(this.callbacks[V])),o||this.isInViewport||(i(this.callbacks[v]),i(this.callbacks[y]))),!this.isFullyInViewport&&n&&i(this.callbacks[V]),!this.isInViewport&&o&&i(this.callbacks[y]),this.isInViewport!==o&&i(this.callbacks[g]),!0){case o!==this.isInViewport:case n!==this.isFullyInViewport:case r!==this.isAboveViewport:case s!==this.isBelowViewport:i(this.callbacks[k])}o=this.isInViewport,n=this.isFullyInViewport,r=this.isAboveViewport,s=this.isBelowViewport},this.recalculateLocation=function(){if(!this.locked){var t=this.top,e=this.bottom;if(this.watchItem.nodeName){var o=this.watchItem.style.display;"none"===o&&(this.watchItem.style.display="");var n=d(this.watchItem).offset();this.top=n.top,this.bottom=n.top+this.watchItem.offsetHeight,"none"===o&&(this.watchItem.style.display=o)}else this.watchItem===+this.watchItem?0<this.watchItem?this.top=this.bottom=this.watchItem:this.top=this.bottom=f.documentHeight-this.watchItem:(this.top=this.watchItem.top,this.bottom=this.watchItem.bottom);this.top-=this.offsets.top,this.bottom+=this.offsets.bottom,this.height=this.bottom-this.top,t===undefined&&e===undefined||this.top===t&&this.bottom===e||i(this.callbacks[x])}},this.recalculateLocation(),this.update(),o=this.isInViewport,n=this.isFullyInViewport,r=this.isAboveViewport,s=this.isBelowViewport}function s(t){h=t,e(),i()}var a,h,l,c,u,f={},p=d(window),m=d(document),w=[],g="visibilityChange",v="enterViewport",b="fullyEnterViewport",y="exitViewport",V="partiallyExitViewport",x="locationChange",k="stateChange",T=[g,v,b,y,V,x,k],I={top:0,bottom:0};f.viewportTop,f.viewportBottom,f.documentHeight,f.viewportHeight=t(),r.prototype={on:function(t,e,o){switch(!0){case t===g&&!this.isInViewport&&this.isAboveViewport:case t===v&&this.isInViewport:case t===b&&this.isFullyInViewport:case t===y&&this.isAboveViewport&&!this.isInViewport:case t===V&&this.isAboveViewport:if(e(),o)return}if(!this.callbacks[t])throw new Error("Tried to add a scroll monitor listener of type "+t+". Your options are: "+T.join(", "));this.callbacks[t].push({callback:e,isOne:o})},off:function(t,e){if(!this.callbacks[t])throw new Error("Tried to remove a scroll monitor listener of type "+t+". Your options are: "+T.join(", "));for(var o,n=0;o=this.callbacks[t][n];n++)if(o.callback===e){this.callbacks[t].splice(n,1);break}},one:function(t,e){this.on(t,e,!0)},recalculateSize:function(){this.height=this.watchItem.offsetHeight+this.offsets.top+this.offsets.bottom,this.bottom=this.top+this.height},update:function(){this.isAboveViewport=this.top<f.viewportTop,this.isBelowViewport=this.bottom>f.viewportBottom,this.isInViewport=this.top<=f.viewportBottom&&this.bottom>=f.viewportTop,this.isFullyInViewport=this.top>=f.viewportTop&&this.bottom<=f.viewportBottom||this.isAboveViewport&&this.isBelowViewport},destroy:function(){var t=w.indexOf(this),e=this;w.splice(t,1);for(var o=0,n=T.length;o<n;o++)e.callbacks[T[o]].length=0},lock:function(){this.locked=!0},unlock:function(){this.locked=!1}};for(var S=function(o){return function(t,e){this.on.call(this,o,t,e)}},C=0,z=T.length;C<z;C++){var _=T[C];r.prototype[_]=S(_)}try{e()}catch(D){d(e)}return p.on("scroll",s),p.on("resize",n),f.beget=f.create=function(t,e){"string"==typeof t&&(t=d(t)[0]),t instanceof d&&(t=t[0]);var o=new r(t,e);return w.push(o),o.update(),o},f.update=function(){h=null,e(),i()},f.recalculateLocations=function(){f.documentHeight=0,f.update()},f}),function(t){"use strict";"function"==typeof define&&define.amd?define(["jquery"],t):"object"==typeof exports?t(require("jquery")):t(jQuery)}(function(Z){"use strict";function tt(t){return"string"==typeof t?parseInt(t,10):~~t}var et={wheelSpeed:1,wheelPropagation:!1,swipePropagation:!0,minScrollbarLength:null,maxScrollbarLength:null,useBothWheelAxes:!1,useKeyboard:!0,suppressScrollX:!1,suppressScrollY:!1,scrollXMarginOffset:0,scrollYMarginOffset:0,includePadding:!1},t=0,ot=function(){var o=t++;return function(t){var e=".perfect-scrollbar-"+o;return void 0===t?e:t+e}},nt="WebkitAppearance"in document.documentElement.style;Z.fn.perfectScrollbar=function(G,J){return this.each(function(){function r(t,e){var o=t+e,n=V-_,i=tt((D=o<0?0:n<o?n:o)*(k-V)/(V-_));v.scrollTop(i)}function s(t,e){var o=t+e,n=y-I,i=tt((S=o<0?0:n<o?n:o)*(x-y)/(y-I));v.scrollLeft(i)}function t(t){return m.minScrollbarLength&&(t=Math.max(t,m.minScrollbarLength)),m.maxScrollbarLength&&(t=Math.min(t,m.maxScrollbarLength)),t}function e(){var t={width:C};t.left=L?v.scrollLeft()+y-x:v.scrollLeft(),H?t.bottom=Y-v.scrollTop():t.top=j+v.scrollTop(),M.css(t);var e={top:v.scrollTop(),height:E};q?e.right=L?x-v.scrollLeft()-B-X.outerWidth():B-v.scrollLeft():e.left=L?v.scrollLeft()+2*y-x-R-X.outerWidth():R+v.scrollLeft(),O.css(e),P.css({left:S,width:I-N}),X.css({top:D,height:_-U})}function w(){v.removeClass("ps-active-x"),v.removeClass("ps-active-y"),y=m.includePadding?v.innerWidth():v.width(),V=m.includePadding?v.innerHeight():v.height(),x=v.prop("scrollWidth"),k=v.prop("scrollHeight"),!m.suppressScrollX&&x>y+m.scrollXMarginOffset?(T=!0,I=t(tt((C=y-W)*y/x)),S=tt(v.scrollLeft()*(C-I)/(x-y))):(T=!1,S=I=0,v.scrollLeft(0)),!m.suppressScrollY&&k>V+m.scrollYMarginOffset?(z=!0,_=t(tt((E=V-K)*V/k)),D=tt(v.scrollTop()*(E-_)/(k-V))):(z=!1,D=_=0,v.scrollTop(0)),C-I<=S&&(S=C-I),E-_<=D&&(D=E-_),e(),T&&v.addClass("ps-active-x"),z&&v.addClass("ps-active-y")}function o(){var e,o,n=function(t){s(e,t.pageX-o),w(),t.stopPropagation(),t.preventDefault()},i=function(){M.removeClass("in-scrolling"),Z(A).unbind(F("mousemove"),n)};P.bind(F("mousedown"),function(t){o=t.pageX,e=P.position().left,M.addClass("in-scrolling"),Z(A).bind(F("mousemove"),n),Z(A).one(F("mouseup"),i),t.stopPropagation(),t.preventDefault()}),e=o=null}function n(){var e,o,n=function(t){r(e,t.pageY-o),w(),t.stopPropagation(),t.preventDefault()},i=function(){O.removeClass("in-scrolling"),Z(A).unbind(F("mousemove"),n)};X.bind(F("mousedown"),function(t){o=t.pageY,e=X.position().top,O.addClass("in-scrolling"),Z(A).bind(F("mousemove"),n),Z(A).one(F("mouseup"),i),t.stopPropagation(),t.preventDefault()}),e=o=null}function a(t,e){var o=v.scrollTop();if(0===t){if(!z)return!1;if(0===o&&0<e||k-V<=o&&e<0)return!m.wheelPropagation}var n=v.scrollLeft();if(0===e){if(!T)return!1;if(0===n&&t<0||x-y<=n&&0<t)return!m.wheelPropagation}return!0}function g(t,e){var o=v.scrollTop(),n=v.scrollLeft(),i=Math.abs(t),r=Math.abs(e);if(i<r){if(e<0&&o===k-V||0<e&&0===o)return!m.swipePropagation}else if(r<i&&(t<0&&n===x-y||0<t&&0===n))return!m.swipePropagation;return!0}function i(){function i(t){var e=t.originalEvent.deltaX,o=-1*t.originalEvent.deltaY;return(void 0===e||void 0===o)&&(e=-1*t.originalEvent.wheelDeltaX/6,o=t.originalEvent.wheelDeltaY/6),t.originalEvent.deltaMode&&1===t.originalEvent.deltaMode&&(e*=10,o*=10),e!=e&&o!=o&&(e=0,o=t.originalEvent.wheelDelta),[e,o]}function t(t){if(nt||!(0<v.find("select:focus").length)){var e=i(t),o=e[0],n=e[1];r=!1,m.useBothWheelAxes?z&&!T?(n?v.scrollTop(v.scrollTop()-n*m.wheelSpeed):v.scrollTop(v.scrollTop()+o*m.wheelSpeed),r=!0):T&&!z&&(o?v.scrollLeft(v.scrollLeft()+o*m.wheelSpeed):v.scrollLeft(v.scrollLeft()-n*m.wheelSpeed),r=!0):(v.scrollTop(v.scrollTop()-n*m.wheelSpeed),v.scrollLeft(v.scrollLeft()+o*m.wheelSpeed)),w(),(r=r||a(o,n))&&(t.stopPropagation(),t.preventDefault())}}var r=!1;void 0!==window.onwheel?v.bind(F("wheel"),t):void 0!==window.onmousewheel&&v.bind(F("mousewheel"),t)}function l(){var i=!1;v.bind(F("mouseenter"),function(){i=!0}),v.bind(F("mouseleave"),function(){i=!1});Z(A).bind(F("keydown"),function(t){if((!t.isDefaultPrevented||!t.isDefaultPrevented())&&i){for(var e=document.activeElement?document.activeElement:A.activeElement;e.shadowRoot;)e=e.shadowRoot.activeElement;if(!Z(e).is(":input,[contenteditable]")){var o=0,n=0;switch(t.which){case 37:o=-30;break;case 38:n=30;break;case 39:o=30;break;case 40:n=-30;break;case 33:n=90;break;case 32:case 34:n=-90;break;case 35:n=t.ctrlKey?-k:-V;break;case 36:n=t.ctrlKey?v.scrollTop():V;break;default:return}v.scrollTop(v.scrollTop()-n),v.scrollLeft(v.scrollLeft()+o),a(o,n)&&t.preventDefault()}}})}function c(){function t(t){t.stopPropagation()}X.bind(F("click"),t),O.bind(F("click"),function(t){var e=tt(_/2),o=(t.pageY-O.offset().top-e)/(V-_);o<0?o=0:1<o&&(o=1),v.scrollTop((k-V)*o)}),P.bind(F("click"),t),M.bind(F("click"),function(t){var e=tt(I/2),o=(t.pageX-M.offset().left-e)/(y-I);o<0?o=0:1<o&&(o=1),v.scrollLeft((x-y)*o)})}function u(){function t(){var t=window.getSelection?window.getSelection():document.getSlection?document.getSlection():{rangeCount:0};return 0===t.rangeCount?null:t.getRangeAt(0).commonAncestorContainer}function i(){e||(e=setInterval(function(){return b()?(v.scrollTop(v.scrollTop()+s.top),v.scrollLeft(v.scrollLeft()+s.left),void w()):void clearInterval(e)},50))}function r(){e&&(clearInterval(e),e=null),M.removeClass("in-scrolling"),O.removeClass("in-scrolling")}var e=null,s={top:0,left:0},a=!1;Z(A).bind(F("selectionchange"),function(){Z.contains(v[0],t())?a=!0:(a=!1,r())}),Z(window).bind(F("mouseup"),function(){a&&(a=!1,r())}),Z(window).bind(F("mousemove"),function(t){if(a){var e={x:t.pageX,y:t.pageY},o=v.offset(),n={left:o.left,right:o.left+v.outerWidth(),top:o.top,bottom:o.top+v.outerHeight()};e.x<n.left+3?(s.left=-5,M.addClass("in-scrolling")):e.x>n.right-3?(s.left=5,M.addClass("in-scrolling")):s.left=0,e.y<n.top+3?(s.top=n.top+3-e.y<5?-5:-20,O.addClass("in-scrolling")):e.y>n.bottom-3?(s.top=e.y-n.bottom+3<5?5:20,O.addClass("in-scrolling")):s.top=0,0===s.top&&0===s.left?r():i()}})}function p(t,e){function a(t,e){v.scrollTop(v.scrollTop()-e),v.scrollLeft(v.scrollLeft()-t),w()}function o(){f=!0}function n(){f=!1}function l(t){return t.originalEvent.targetTouches?t.originalEvent.targetTouches[0]:t.originalEvent}function c(t){var e=t.originalEvent;return!(!e.targetTouches||1!==e.targetTouches.length)||!(!e.pointerType||"mouse"===e.pointerType||e.pointerType===e.MSPOINTER_TYPE_MOUSE)}function i(t){if(c(t)){m=!0;var e=l(t);u.pageX=e.pageX,u.pageY=e.pageY,p=(new Date).getTime(),null!==h&&clearInterval(h),t.stopPropagation()}}function r(t){if(!f&&m&&c(t)){var e=l(t),o={pageX:e.pageX,pageY:e.pageY},n=o.pageX-u.pageX,i=o.pageY-u.pageY;a(n,i),u=o;var r=(new Date).getTime(),s=r-p;0<s&&(d.x=n/s,d.y=i/s,p=r),g(n,i)&&(t.stopPropagation(),t.preventDefault())}}function s(){!f&&m&&(m=!1,clearInterval(h),h=setInterval(function(){return b()?Math.abs(d.x)<.01&&Math.abs(d.y)<.01?void clearInterval(h):(a(30*d.x,30*d.y),d.x*=.8,void(d.y*=.8)):void clearInterval(h)},10))}var u={},p=0,d={},h=null,f=!1,m=!1;t&&(Z(window).bind(F("touchstart"),o),Z(window).bind(F("touchend"),n),v.bind(F("touchstart"),i),v.bind(F("touchmove"),r),v.bind(F("touchend"),s)),e&&(window.PointerEvent?(Z(window).bind(F("pointerdown"),o),Z(window).bind(F("pointerup"),n),v.bind(F("pointerdown"),i),v.bind(F("pointermove"),r),v.bind(F("pointerup"),s)):window.MSPointerEvent&&(Z(window).bind(F("MSPointerDown"),o),Z(window).bind(F("MSPointerUp"),n),v.bind(F("MSPointerDown"),i),v.bind(F("MSPointerMove"),r),v.bind(F("MSPointerUp"),s)))}function d(){v.bind(F("scroll"),function(){w()})}function h(){v.unbind(F()),Z(window).unbind(F()),Z(A).unbind(F()),v.data("perfect-scrollbar",null),v.data("perfect-scrollbar-update",null),v.data("perfect-scrollbar-destroy",null),P.remove(),X.remove(),M.remove(),O.remove(),v=M=O=P=X=T=z=y=V=x=k=I=S=Y=H=j=_=D=B=q=R=L=F=null}function f(){w(),d(),o(),n(),c(),u(),i(),($||Q)&&p($,Q),m.useKeyboard&&l(),v.data("perfect-scrollbar",v),v.data("perfect-scrollbar-update",w),v.data("perfect-scrollbar-destroy",h)}var m=Z.extend(!0,{},et),v=Z(this),b=function(){return!!v};if("object"==typeof G?Z.extend(!0,m,G):J=G,"update"===J)return v.data("perfect-scrollbar-update")&&v.data("perfect-scrollbar-update")(),v;if("destroy"===J)return v.data("perfect-scrollbar-destroy")&&v.data("perfect-scrollbar-destroy")(),v;if(v.data("perfect-scrollbar"))return v.data("perfect-scrollbar");v.addClass("ps-container");var y,V,x,k,T,I,S,C,z,_,D,E,L="rtl"===v.css("direction"),F=ot(),A=this.ownerDocument||document,M=Z("<div class='ps-scrollbar-x-rail'>").appendTo(v),P=Z("<div class='ps-scrollbar-x'>").appendTo(M),Y=tt(M.css("bottom")),H=Y==Y,j=H?null:tt(M.css("top")),N=tt(M.css("borderLeftWidth"))+tt(M.css("borderRightWidth")),W=tt(M.css("marginLeft"))+tt(M.css("marginRight")),O=Z("<div class='ps-scrollbar-y-rail'>").appendTo(v),X=Z("<div class='ps-scrollbar-y'>").appendTo(O),B=tt(O.css("right")),q=B==B,R=q?null:tt(O.css("left")),U=tt(O.css("borderTopWidth"))+tt(O.css("borderBottomWidth")),K=tt(O.css("marginTop"))+tt(O.css("marginBottom")),$="ontouchstart"in window||window.DocumentTouch&&document instanceof window.DocumentTouch,Q=null!==window.navigator.msMaxTouchPoints;return f(),v})}}),function(d){d.fn.hoverIntent=function(t,e,o){var n,i,r,s,a={interval:100,sensitivity:6,timeout:0};a="object"==typeof t?d.extend(a,t):d.isFunction(e)?d.extend(a,{over:t,out:e,selector:o}):d.extend(a,{over:t,out:t,selector:e});var l=function(t){n=t.pageX,i=t.pageY},c=function(t,e){if(e.hoverIntent_t=clearTimeout(e.hoverIntent_t),Math.sqrt((r-n)*(r-n)+(s-i)*(s-i))<a.sensitivity)return d(e).off("mousemove.hoverIntent",l),e.hoverIntent_s=!0,a.over.apply(e,[t]);r=n,s=i,e.hoverIntent_t=setTimeout(function(){c(t,e)},a.interval)},u=function(t,e){return e.hoverIntent_t=clearTimeout(e.hoverIntent_t),e.hoverIntent_s=!1,a.out.apply(e,[t])},p=function(t){var e=d.extend({},t),o=this;o.hoverIntent_t&&(o.hoverIntent_t=clearTimeout(o.hoverIntent_t)),"mouseenter"===t.type?(r=e.pageX,s=e.pageY,d(o).on("mousemove.hoverIntent",l),o.hoverIntent_s||(o.hoverIntent_t=setTimeout(function(){c(e,o)},a.interval))):(d(o).off("mousemove.hoverIntent",l),o.hoverIntent_s&&(o.hoverIntent_t=setTimeout(function(){u(e,o)},a.timeout)))};return this.on({"mouseenter.hoverIntent":p,"mouseleave.hoverIntent":p},a.selector)}}(jQuery),function(i){"use strict";var r=function(t,e,o){return 1===arguments.length?r.get(t):r.set(t,e,o)};r._document=document,r._navigator=navigator,r.defaults={path:"/"},r.get=function(t){return r._cachedDocumentCookie!==r._document.cookie&&r._renewCache(),r._cache[t]},r.set=function(t,e,o){return(o=r._getExtendedOptions(o)).expires=r._getExpiresDate(e===i?-1:o.expires),r._document.cookie=r._generateCookieString(t,e,o),r},r.expire=function(t,e){return r.set(t,i,e)},r._getExtendedOptions=function(t){return{path:t&&t.path||r.defaults.path,domain:t&&t.domain||r.defaults.domain,expires:t&&t.expires||r.defaults.expires,secure:t&&t.secure!==i?t.secure:r.defaults.secure}},r._isValidDate=function(t){return"[object Date]"===Object.prototype.toString.call(t)&&!isNaN(t.getTime())},r._getExpiresDate=function(t,e){switch(e=e||new Date,typeof t){case"number":t=new Date(e.getTime()+1e3*t);break;case"string":t=new Date(t)}if(t&&!r._isValidDate(t))throw Error("`expires` parameter cannot be converted to a valid Date instance");return t},r._generateCookieString=function(t,e,o){return t=(t=(t=t.replace(/[^#$&+\^`|]/g,encodeURIComponent)).replace(/\(/g,"%28").replace(/\)/g,"%29"))+"="+(e=(e+"").replace(/[^!#$&-+\--:<-\[\]-~]/g,encodeURIComponent))+((o=o||{}).path?";path="+o.path:""),t+=o.domain?";domain="+o.domain:"",(t+=o.expires?";expires="+o.expires.toUTCString():"")+(o.secure?";secure":"")},r._getCookieObjectFromString=function(t){var e={};t=t?t.split("; "):[];for(var o=0;o<t.length;o++){var n=r._getKeyValuePairFromCookieString(t[o]);e[n.key]===i&&(e[n.key]=n.value)}return e},r._getKeyValuePairFromCookieString=function(t){var e=(e=t.indexOf("="))<0?t.length:e;return{key:decodeURIComponent(t.substr(0,e)),value:decodeURIComponent(t.substr(e+1))}},r._renewCache=function(){r._cache=r._getCookieObjectFromString(r._document.cookie),r._cachedDocumentCookie=r._document.cookie},r._areEnabled=function(){var t="1"===r.set("cookies.js",1).get("cookies.js");return r.expire("cookies.js"),t},r.enabled=r._areEnabled(),"function"==typeof define&&define.amd?define(function(){return r}):"undefined"!=typeof exports?("undefined"!=typeof module&&module.exports&&(exports=module.exports=r),exports.Cookies=r):window.Cookies=r}();