function resizable(){is("largescreen"),ismdxl(),is("tabletscreen"),is("tabletscreen")&&(public_vars.$sidebarMenu.addClass("collapsed"),ps_destroy()),isxs(),jQuery(window).trigger("xenon.resize")}function get_current_breakpoint(){var e=jQuery(window).width(),r=public_vars.breakpoints;for(var i in r){var n=r[i],s=n[0],t=n[1];if(-1==t&&(t=e),s<=e&&e<=t)return i}return null}function is(e){return get_current_breakpoint()==e}function isxs(){return is("devicescreen")||is("sdevicescreen")}function ismdxl(){return is("tabletscreen")||is("largescreen")}function trigger_resizable(){public_vars.lastBreakpoint!=get_current_breakpoint()&&(public_vars.lastBreakpoint=get_current_breakpoint(),resizable(public_vars.lastBreakpoint)),jQuery(window).trigger("xenon.resized")}var public_vars=public_vars||{};jQuery.extend(public_vars,{breakpoints:{largescreen:[991,-1],tabletscreen:[768,990],devicescreen:[420,767],sdevicescreen:[0,419]},lastBreakpoint:null});