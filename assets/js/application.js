if (typeof deconcept == "undefined") {
    var deconcept = new Object();
}
if (typeof deconcept.util == "undefined") {
    deconcept.util = new Object();
}
if (typeof deconcept.SWFObjectUtil == "undefined") {
    deconcept.SWFObjectUtil = new Object();
}
deconcept.SWFObject = function(_1, id, w, h, _5, c, _7, _8, _9, _a) {
    if (!document.getElementById) {
        return;
    }
    this.DETECT_KEY = _a ? _a : "detectflash";
    this.skipDetect = deconcept.util.getRequestParameter(this.DETECT_KEY);
    this.params = new Object();
    this.variables = new Object();
    this.attributes = new Array();
    if (_1) {
        this.setAttribute("swf", _1);
    }
    if (id) {
        this.setAttribute("id", id);
    }
    if (w) {
        this.setAttribute("width", w);
    }
    if (h) {
        this.setAttribute("height", h);
    }
    if (_5) {
        this.setAttribute("version", new deconcept.PlayerVersion(_5.toString().split(".")));
    }
    this.installedVer = deconcept.SWFObjectUtil.getPlayerVersion();
    if (!window.opera && document.all && this.installedVer.major > 7) {
        deconcept.SWFObject.doPrepUnload = true;
    }
    if (c) {
        this.addParam("bgcolor", c);
    }
    var q = _7 ? _7 : "high";
    this.addParam("quality", q);
    this.setAttribute("useExpressInstall", false);
    this.setAttribute("doExpressInstall", false);
    var _c = (_8) ? _8 : window.location;
    this.setAttribute("xiRedirectUrl", _c);
    this.setAttribute("redirectUrl", "");
    if (_9) {
        this.setAttribute("redirectUrl", _9);
    }
};
deconcept.SWFObject.prototype = {useExpressInstall: function(_d) {
    this.xiSWFPath = !_d ? "expressinstall.swf" : _d;
    this.setAttribute("useExpressInstall", true);
},setAttribute: function(_e, _f) {
    this.attributes[_e] = _f;
},getAttribute: function(_10) {
    return this.attributes[_10];
},addParam: function(_11, _12) {
    this.params[_11] = _12;
},getParams: function() {
    return this.params;
},addVariable: function(_13, _14) {
    this.variables[_13] = _14;
},getVariable: function(_15) {
    return this.variables[_15];
},getVariables: function() {
    return this.variables;
},getVariablePairs: function() {
    var _16 = new Array();
    var key;
    var _18 = this.getVariables();
    for (key in _18) {
        _16[_16.length] = key + "=" + _18[key];
    }
    return _16;
},getSWFHTML: function() {
    var _19 = "";
    if (navigator.plugins && navigator.mimeTypes && navigator.mimeTypes.length) {
        if (this.getAttribute("doExpressInstall")) {
            this.addVariable("MMplayerType", "PlugIn");
            this.setAttribute("swf", this.xiSWFPath);
        }
        _19 = "<embed type=\"application/x-shockwave-flash\" src=\"" + this.getAttribute("swf") + "\" width=\"" + this.getAttribute("width") + "\" height=\"" + this.getAttribute("height") + "\" style=\"" + this.getAttribute("style") + "\"";
        _19 += " id=\"" + this.getAttribute("id") + "\" name=\"" + this.getAttribute("id") + "\" ";
        var _1a = this.getParams();
        for (var key in _1a) {
            _19 += [key] + "=\"" + _1a[key] + "\" ";
        }
        var _1c = this.getVariablePairs().join("&");
        if (_1c.length > 0) {
            _19 += "flashvars=\"" + _1c + "\"";
        }
        _19 += "/>";
    } else {
        if (this.getAttribute("doExpressInstall")) {
            this.addVariable("MMplayerType", "ActiveX");
            this.setAttribute("swf", this.xiSWFPath);
        }
        _19 = "<object id=\"" + this.getAttribute("id") + "\" classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" width=\"" + this.getAttribute("width") + "\" height=\"" + this.getAttribute("height") + "\" style=\"" + this.getAttribute("style") + "\">";
        _19 += "<param name=\"movie\" value=\"" + this.getAttribute("swf") + "\" />";
        var _1d = this.getParams();
        for (var key in _1d) {
            _19 += "<param name=\"" + key + "\" value=\"" + _1d[key] + "\" />";
        }
        var _1f = this.getVariablePairs().join("&");
        if (_1f.length > 0) {
            _19 += "<param name=\"flashvars\" value=\"" + _1f + "\" />";
        }
        _19 += "</object>";
    }
    return _19;
},write: function(_20) {
    if (this.getAttribute("useExpressInstall")) {
        var _21 = new deconcept.PlayerVersion([6, 0, 65]);
        if (this.installedVer.versionIsValid(_21) && !this.installedVer.versionIsValid(this.getAttribute("version"))) {
            this.setAttribute("doExpressInstall", true);
            this.addVariable("MMredirectURL", escape(this.getAttribute("xiRedirectUrl")));
            document.title = document.title.slice(0, 47) + " - Flash Player Installation";
            this.addVariable("MMdoctitle", document.title);
        }
    }
    if (this.skipDetect || this.getAttribute("doExpressInstall") || this.installedVer.versionIsValid(this.getAttribute("version"))) {
        var n = (typeof _20 == "string") ? document.getElementById(_20) : _20;
        n.innerHTML = this.getSWFHTML();
        return true;
    } else {
        if (this.getAttribute("redirectUrl") != "") {
            document.location.replace(this.getAttribute("redirectUrl"));
        }
    }
    return false;
}};
deconcept.SWFObjectUtil.getPlayerVersion = function() {
    var _23 = new deconcept.PlayerVersion([0, 0, 0]);
    if (navigator.plugins && navigator.mimeTypes.length) {
        var x = navigator.plugins["Shockwave Flash"];
        if (x && x.description) {
            _23 = new deconcept.PlayerVersion(x.description.replace(/([a-zA-Z]|\s)+/, "").replace(/(\s+r|\s+b[0-9]+)/, ".").split("."));
        }
    } else {
        if (navigator.userAgent && navigator.userAgent.indexOf("Windows CE") >= 0) {
            var axo = 1;
            var _26 = 3;
            while (axo) {
                try {
                    _26++;
                    axo = new ActiveXObject("ShockwaveFlash.ShockwaveFlash." + _26);
                    _23 = new deconcept.PlayerVersion([_26, 0, 0]);
                } catch (e) {
                    axo = null;
                }
            }
        } else {
            try {
                var axo = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7");
            } catch (e) {
                try {
                    var axo = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6");
                    _23 = new deconcept.PlayerVersion([6, 0, 21]);
                    axo.AllowScriptAccess = "always";
                } catch (e) {
                    if (_23.major == 6) {
                        return _23;
                    }
                }
                try {
                    axo = new ActiveXObject("ShockwaveFlash.ShockwaveFlash");
                } catch (e) {
                }
            }
            if (axo != null) {
                _23 = new deconcept.PlayerVersion(axo.GetVariable("$version").split(" ")[1].split(","));
            }
        }
    }
    return _23;
};
deconcept.PlayerVersion = function(_29) {
    this.major = _29[0] != null ? parseInt(_29[0]) : 0;
    this.minor = _29[1] != null ? parseInt(_29[1]) : 0;
    this.rev = _29[2] != null ? parseInt(_29[2]) : 0;
};
deconcept.PlayerVersion.prototype.versionIsValid = function(fv) {
    if (this.major < fv.major) {
        return false;
    }
    if (this.major > fv.major) {
        return true;
    }
    if (this.minor < fv.minor) {
        return false;
    }
    if (this.minor > fv.minor) {
        return true;
    }
    if (this.rev < fv.rev) {
        return false;
    }
    return true;
};
deconcept.util = {getRequestParameter: function(_2b) {
    var q = document.location.search || document.location.hash;
    if (_2b == null) {
        return q;
    }
    if (q) {
        var _2d = q.substring(1).split("&");
        for (var i = 0; i < _2d.length; i++) {
            if (_2d[i].substring(0, _2d[i].indexOf("=")) == _2b) {
                return _2d[i].substring((_2d[i].indexOf("=") + 1));
            }
        }
    }
    return "";
}};
deconcept.SWFObjectUtil.cleanupSWFs = function() {
    var _2f = document.getElementsByTagName("OBJECT");
    for (var i = _2f.length - 1; i >= 0; i--) {
        _2f[i].style.display = "none";
        for (var x in _2f[i]) {
            if (typeof _2f[i][x] == "function") {
                _2f[i][x] = function() {
                };
            }
        }
    }
};
if (deconcept.SWFObject.doPrepUnload) {
    if (!deconcept.unloadSet) {
        deconcept.SWFObjectUtil.prepUnload = function() {
            __flash_unloadHandler = function() {
            };
            __flash_savedUnloadHandler = function() {
            };
            window.attachEvent("onunload", deconcept.SWFObjectUtil.cleanupSWFs);
        };
        window.attachEvent("onbeforeunload", deconcept.SWFObjectUtil.prepUnload);
        deconcept.unloadSet = true;
    }
}
if (!document.getElementById && document.all) {
    document.getElementById = function(id) {
        return document.all[id];
    };
}
var getQueryParamValue = deconcept.util.getRequestParameter;
var FlashObject = deconcept.SWFObject;
var SWFObject = deconcept.SWFObject;
var Juggernaut = {debug: true,verbose_debug: false,isIE: /Microsoft/i.test(navigator.appName),hasFirebug: "console" in window && "firebug" in window.console && window.console.firebug.indexOf("1.0") > -1,logFunc: function(msg) {
    Juggernaut.hasFirebug ? console.log("Juggernaut: " + msg) : window.alert("Juggernaut: " + msg)
},listenToChannels: function(options) {
    Juggernaut._setupOptions(options);
    jQuery(window).load(function() {
        Juggernaut._appendFlashObject();
    });
},receiveData: function(data) {
    if (Juggernaut.base64) {
        var decodedData = Juggernaut._decode64(data);
        Juggernaut._verbose_log("Received data:\n" + decodedData);
        eval(Juggernaut._utf8to16(decodedData));
    } else {
        Juggernaut._verbose_log("Received data:\n" + data);
        eval(data);
    }
    if (juggernautReceiveData) {
        juggernautReceiveData(data);
    }
},connected: function() {
    Juggernaut._verbose_log('You have been connected');
    if (juggernautConnected) {
        juggernautConnected();
    }
},errorConnecting: function() {
    Juggernaut._log('There has been an error connection, please check the push server and make sure your firewall has the correct ports open');
    if (juggernautErrorConnecting) {
        juggernautErrorConnecting();
    }
},disconnected: function() {
    Juggernaut._log('Connection has been lost. Please log out and log back in for chat and collaborative functionality.');
    if (juggernautDisconnected) {
        juggernautDisconnected();
    }
},_setupOptions: function(options) {
    Juggernaut.host = options['host'] || 'localhost';
    Juggernaut.port = options['port'] || 443;
    Juggernaut.ses_id = options['ses_id'];
    Juggernaut.num_tries = options['num_tries'];
    Juggernaut.num_secs = options['num_secs'];
    Juggernaut.unique_id = options['unique_id'] || null;
    Juggernaut.base64 = options['base64'] || false;
    Juggernaut.swf_address = options['swf_address']
    var data = ''
    if (options['channel']) {
        data = '"' + options['channel'] + '"';
    } else if (options['channels']) {
        data = options['channels'].map(function(c) {
            return '"' + c + '"'
        }).join(',');
    }
    Juggernaut.channels = encodeURIComponent(data);
},_appendFlashObject: function() {
    var so = new SWFObject(Juggernaut.swf_address, "juggernaut_flash", "1", "1", "8", "#ffffff");
    so.useExpressInstall('/expressinstall.swf');
    so.addVariable("host", Juggernaut.host);
    so.addVariable("port", Juggernaut.port);
    so.addVariable("channels", Juggernaut.channels);
    so.addVariable("ses_id", Juggernaut.ses_id);
    so.addVariable("num_tries", Juggernaut.num_tries);
    so.addVariable("num_secs", Juggernaut.num_secs);
    so.addVariable("unique_id", Juggernaut.unique_id);
    so.addVariable("bridgeName", 'juggernaut');
    so.write("flashcontent");
},_log: function(msg) {
    if (Juggernaut.debug) {
        Juggernaut.logFunc(msg);
    }
},_verbose_log: function(msg) {
    if (Juggernaut.verbose_debug) {
        Juggernaut.logFunc(msg);
    }
},_decode64: function(input) {
    var keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    var output = "";
    var chr1, chr2, chr3;
    var enc1, enc2, enc3, enc4;
    var i = 0;
    input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
    do {
        enc1 = keyStr.indexOf(input.charAt(i++));
        enc2 = keyStr.indexOf(input.charAt(i++));
        enc3 = keyStr.indexOf(input.charAt(i++));
        enc4 = keyStr.indexOf(input.charAt(i++));
        chr1 = (enc1 << 2) | (enc2 >> 4);
        chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
        chr3 = ((enc3 & 3) << 6) | enc4;
        output = output + String.fromCharCode(chr1);
        if (enc3 != 64) {
            output = output + String.fromCharCode(chr2);
        }
        if (enc4 != 64) {
            output = output + String.fromCharCode(chr3);
        }
    } while (i < input.length);
    return output;
},_utf8to16: function(str) {
    var out, i, len, c;
    var char2, char3;
    out = "";
    len = str.length;
    i = 0;
    while (i < len) {
        c = str.charCodeAt(i++);
        switch (c >> 4) {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
                out += str.charAt(i - 1);
                break;
            case 12:
            case 13:
                char2 = str.charCodeAt(i++);
                out += String.fromCharCode(((c & 0x1F) << 6) | (char2 & 0x3F));
                break;
            case 14:
                char2 = str.charCodeAt(i++);
                char3 = str.charCodeAt(i++);
                out += String.fromCharCode(((c & 0x0F) << 12) | ((char2 & 0x3F) << 6) | ((char3 & 0x3F) << 0));
                break;
        }
    }
    return out;
}};
function receiveData(d) {
    Juggernaut.receiveData(d);
}
function ajax_error(error) {
    alert(error);
}
function thisMovie(movieName) {
    if (navigator.appName.indexOf("Microsoft") != -1) {
        return window[movieName];
    } else {
        return document[movieName];
    }
}
function date_element_date_updated(cal, main_id) {
    var store_id = main_id + '_store';
    if ($F(store_id).length == 0) {
        var curtime = $(new Date).toJSON();
        $(store_id).value = curtime.substr(0, 10) + ' 00:00';
    }
    var d = cal.date.print('%Y-%m-%d');
    var h = $F(store_id).substr(11, 2);
    var m = $F(store_id).substr(14, 2);
    $(store_id).value = d + ' ' + h + ':' + m;
}
function date_element_hour_updated(main_id) {
    var store_id = main_id + '_store';
    if ($F(store_id).length == 0) {
        var curtime = (new Date).toJSON();
        $(store_id).value = curtime.substr(0, 10) + ' 00:00';
    }
    var d = $F(store_id).substr(0, 10);
    var h = $F(main_id + '_hour');
    var m = $F(store_id).substr(14, 2);
    $(store_id).value = d + ' ' + h + ':' + m;
}
function date_element_minute_updated(main_id) {
    var store_id = main_id + '_store';
    if ($F(store_id).length == 0) {
        var curtime = (new Date).toJSON();
        $(store_id).value = curtime.substr(0, 10) + ' 00:00';
    }
    var d = $F(store_id).substr(0, 10);
    var h = $F(store_id).substr(11, 2);
    var m = $F(main_id + '_minute');
    $(store_id).value = d + ' ' + h + ':' + m;
}
function time_interval_element_updated(main_id) {
    $(main_id).value = $F(main_id + '_negative') + (parseInt($F(main_id + '_days')) * 86400 +
        parseInt($F(main_id + '_hours')) * 3600 +
        parseInt($F(main_id + '_minutes')) * 60);
}
function time_interval_element_toggle_negative(main_id, positive_text, negative_text) {
    var prev = $F(main_id);
    if ($F(main_id + '_negative') == '-') {
        $(main_id + '_negative').value = '';
        if (prev.length > 0) {
            $(main_id).value = prev.substr(1, prev.length);
        }
        Element.update(main_id + '_negative_button', positive_text);
    } else {
        $(main_id + '_negative').value = '-';
        if (prev.length > 0) {
            $(main_id).value = '-' + prev;
        }
        Element.update(main_id + '_negative_button', negative_text);
    }
}
function clear_date_field(show_id, store_id) {
    $(show_id).update('vali kuupäev');
    $(store_id).value = '';
}
function set_active_screen(ul_id, screen_id) {
    $$('#' + ul_id + ' li.selected').each(function(s) {
        s.className = '';
    });
    $(screen_id).className = 'selected';
}
var Cookie = {set: function(name, value, path, daysToExpire) {
    var expire = '';
    if (daysToExpire != undefined) {
        var d = new Date();
        d.setTime(d.getTime() + (86400000 * parseFloat(daysToExpire)));
        expire = '; expires=' + d.toGMTString();
    }
    if (path) {
        path = ';path=' + path;
    } else {
        path = '';
    }
    return (document.cookie = escape(name) + '=' + escape(value || '') + expire + path);
},get: function(name) {
    var cookie = document.cookie.match(new RegExp('(^|;)\\s*' + escape(name) + '=([^;\\s]*)'));
    return (cookie ? unescape(cookie[2]) : null);
},erase: function(name) {
    var cookie = Cookie.get(name) || true;
    Cookie.set(name, '', -1);
    return cookie;
},accept: function() {
    if (typeof navigator.cookieEnabled == 'boolean') {
        return navigator.cookieEnabled;
    }
    Cookie.set('_test', '1');
    return (Cookie.erase('_test') === '1');
}};
function do_print() {
    if (typeof $('appletDiv').down().print != 'undefined')
        printTickets();
    else
        setTimeout(do_print, 1000);
}
function ticketsPrinted()
{
    alert('Trükitud!');
}
function debug()
{
    if (typeof (console) != 'undefined') {
        console.log(arguments);
    }
}
$("#osta-pilet-katkesta").click(function() {
    hideEditor();
    hide_time_out_message();
});
Calendar = function(firstDayOfWeek, dateStr, onSelected, onClose) {
    this.activeDiv = null;
    this.currentDateEl = null;
    this.getDateStatus = null;
    this.getDateToolTip = null;
    this.getDateText = null;
    this.timeout = null;
    this.onSelected = onSelected || null;
    this.onClose = onClose || null;
    this.dragging = false;
    this.hidden = false;
    this.minYear = 1970;
    this.maxYear = 2050;
    this.dateFormat = Calendar._TT["DEF_DATE_FORMAT"];
    this.ttDateFormat = Calendar._TT["TT_DATE_FORMAT"];
    this.isPopup = true;
    this.weekNumbers = true;
    this.firstDayOfWeek = typeof firstDayOfWeek == "number" ? firstDayOfWeek : Calendar._FD;
    this.showsOtherMonths = false;
    this.dateStr = dateStr;
    this.ar_days = null;
    this.showsTime = false;
    this.time24 = true;
    this.yearStep = 2;
    this.hiliteToday = true;
    this.multiple = null;
    this.table = null;
    this.element = null;
    this.tbody = null;
    this.firstdayname = null;
    this.monthsCombo = null;
    this.yearsCombo = null;
    this.hilitedMonth = null;
    this.activeMonth = null;
    this.hilitedYear = null;
    this.activeYear = null;
    this.dateClicked = false;
    if (typeof Calendar._SDN == "undefined") {
        if (typeof Calendar._SDN_len == "undefined")
            Calendar._SDN_len = 3;
        var ar = new Array();
        for (var i = 8; i > 0; ) {
            ar[--i] = Calendar._DN[i].substr(0, Calendar._SDN_len);
        }
        Calendar._SDN = ar;
        if (typeof Calendar._SMN_len == "undefined")
            Calendar._SMN_len = 3;
        ar = new Array();
        for (var i = 12; i > 0; ) {
            ar[--i] = Calendar._MN[i].substr(0, Calendar._SMN_len);
        }
        Calendar._SMN = ar;
    }
};
Calendar._C = null;
Calendar.is_ie = (/msie/i.test(navigator.userAgent) && !/opera/i.test(navigator.userAgent));
Calendar.is_ie5 = (Calendar.is_ie && /msie 5\.0/i.test(navigator.userAgent));
Calendar.is_opera = /opera/i.test(navigator.userAgent);
Calendar.is_khtml = /Konqueror|Safari|KHTML/i.test(navigator.userAgent);
Calendar.getAbsolutePos = function(el) {
    var SL = 0, ST = 0;
    var is_div = /^div$/i.test(el.tagName);
    if (is_div && el.scrollLeft)
        SL = el.scrollLeft;
    if (is_div && el.scrollTop)
        ST = el.scrollTop;
    var r = {x: el.offsetLeft - SL,y: el.offsetTop - ST};
    if (el.offsetParent) {
        var tmp = this.getAbsolutePos(el.offsetParent);
        r.x += tmp.x;
        r.y += tmp.y;
    }
    return r;
};
Calendar.isRelated = function(el, evt) {
    var related = evt.relatedTarget;
    if (!related) {
        var type = evt.type;
        if (type == "mouseover") {
            related = evt.fromElement;
        } else if (type == "mouseout") {
            related = evt.toElement;
        }
    }
    while (related) {
        if (related == el) {
            return true;
        }
        related = related.parentNode;
    }
    return false;
};
Calendar.removeClass = function(el, className) {
    if (!(el && el.className)) {
        return;
    }
    var cls = el.className.split(" ");
    var ar = new Array();
    for (var i = cls.length; i > 0; ) {
        if (cls[--i] != className) {
            ar[ar.length] = cls[i];
        }
    }
    el.className = ar.join(" ");
};
Calendar.addClass = function(el, className) {
    Calendar.removeClass(el, className);
    el.className += " " + className;
};
Calendar.getElement = function(ev) {
    var f = Calendar.is_ie ? window.event.srcElement : ev.currentTarget;
    while (f.nodeType != 1 || /^div$/i.test(f.tagName))
        f = f.parentNode;
    return f;
};
Calendar.getTargetElement = function(ev) {
    var f = Calendar.is_ie ? window.event.srcElement : ev.target;
    while (f.nodeType != 1)
        f = f.parentNode;
    return f;
};
Calendar.stopEvent = function(ev) {
    ev || (ev = window.event);
    if (Calendar.is_ie) {
        ev.cancelBubble = true;
        ev.returnValue = false;
    } else {
        ev.preventDefault();
        ev.stopPropagation();
    }
    return false;
};
Calendar.addEvent = function(el, evname, func) {
    if (el.attachEvent) {
        el.attachEvent("on" + evname, func);
    } else if (el.addEventListener) {
        el.addEventListener(evname, func, true);
    } else {
        el["on" + evname] = func;
    }
};
Calendar.removeEvent = function(el, evname, func) {
    if (el.detachEvent) {
        el.detachEvent("on" + evname, func);
    } else if (el.removeEventListener) {
        el.removeEventListener(evname, func, true);
    } else {
        el["on" + evname] = null;
    }
};
Calendar.createElement = function(type, parent) {
    var el = null;
    if (document.createElementNS) {
        el = document.createElementNS("http://www.w3.org/1999/xhtml", type);
    } else {
        el = document.createElement(type);
    }
    if (typeof parent != "undefined") {
        parent.appendChild(el);
    }
    return el;
};
Calendar._add_evs = function(el) {
    with (Calendar) {
        addEvent(el, "mouseover", dayMouseOver);
        addEvent(el, "mousedown", dayMouseDown);
        addEvent(el, "mouseout", dayMouseOut);
        if (is_ie) {
            addEvent(el, "dblclick", dayMouseDblClick);
            el.setAttribute("unselectable", true);
        }
    }
};
Calendar.findMonth = function(el) {
    if (typeof el.month != "undefined") {
        return el;
    } else if (typeof el.parentNode.month != "undefined") {
        return el.parentNode;
    }
    return null;
};
Calendar.findYear = function(el) {
    if (typeof el.year != "undefined") {
        return el;
    } else if (typeof el.parentNode.year != "undefined") {
        return el.parentNode;
    }
    return null;
};
Calendar.showMonthsCombo = function() {
    var cal = Calendar._C;
    if (!cal) {
        return false;
    }
    var cal = cal;
    var cd = cal.activeDiv;
    var mc = cal.monthsCombo;
    if (cal.hilitedMonth) {
        Calendar.removeClass(cal.hilitedMonth, "hilite");
    }
    if (cal.activeMonth) {
        Calendar.removeClass(cal.activeMonth, "active");
    }
    var mon = cal.monthsCombo.getElementsByTagName("div")[cal.date.getMonth()];
    Calendar.addClass(mon, "active");
    cal.activeMonth = mon;
    var s = mc.style;
    s.display = "block";
    if (cd.navtype < 0)
        s.left = cd.offsetLeft + "px";
    else {
        var mcw = mc.offsetWidth;
        if (typeof mcw == "undefined")
            mcw = 50;
        s.left = (cd.offsetLeft + cd.offsetWidth - mcw) + "px";
    }
    s.top = (cd.offsetTop + cd.offsetHeight) + "px";
};
Calendar.showYearsCombo = function(fwd) {
    var cal = Calendar._C;
    if (!cal) {
        return false;
    }
    var cal = cal;
    var cd = cal.activeDiv;
    var yc = cal.yearsCombo;
    if (cal.hilitedYear) {
        Calendar.removeClass(cal.hilitedYear, "hilite");
    }
    if (cal.activeYear) {
        Calendar.removeClass(cal.activeYear, "active");
    }
    cal.activeYear = null;
    var Y = cal.date.getFullYear() + (fwd ? 1 : -1);
    var yr = yc.firstChild;
    var show = false;
    for (var i = 12; i > 0; --i) {
        if (Y >= cal.minYear && Y <= cal.maxYear) {
            yr.innerHTML = Y;
            yr.year = Y;
            yr.style.display = "block";
            show = true;
        } else {
            yr.style.display = "none";
        }
        yr = yr.nextSibling;
        Y += fwd ? cal.yearStep : -cal.yearStep;
    }
    if (show) {
        var s = yc.style;
        s.display = "block";
        if (cd.navtype < 0)
            s.left = cd.offsetLeft + "px";
        else {
            var ycw = yc.offsetWidth;
            if (typeof ycw == "undefined")
                ycw = 50;
            s.left = (cd.offsetLeft + cd.offsetWidth - ycw) + "px";
        }
        s.top = (cd.offsetTop + cd.offsetHeight) + "px";
    }
};
Calendar.tableMouseUp = function(ev) {
    var cal = Calendar._C;
    if (!cal) {
        return false;
    }
    if (cal.timeout) {
        clearTimeout(cal.timeout);
    }
    var el = cal.activeDiv;
    if (!el) {
        return false;
    }
    var target = Calendar.getTargetElement(ev);
    ev || (ev = window.event);
    Calendar.removeClass(el, "active");
    if (target == el || target.parentNode == el) {
        Calendar.cellClick(el, ev);
    }
    var mon = Calendar.findMonth(target);
    var date = null;
    if (mon) {
        date = new Date(cal.date);
        if (mon.month != date.getMonth()) {
            date.setMonth(mon.month);
            cal.setDate(date);
            cal.dateClicked = false;
            cal.callHandler();
        }
    } else {
        var year = Calendar.findYear(target);
        if (year) {
            date = new Date(cal.date);
            if (year.year != date.getFullYear()) {
                date.setFullYear(year.year);
                cal.setDate(date);
                cal.dateClicked = false;
                cal.callHandler();
            }
        }
    }
    with (Calendar) {
        removeEvent(document, "mouseup", tableMouseUp);
        removeEvent(document, "mouseover", tableMouseOver);
        removeEvent(document, "mousemove", tableMouseOver);
        cal._hideCombos();
        _C = null;
        return stopEvent(ev);
    }
};
Calendar.tableMouseOver = function(ev) {
    var cal = Calendar._C;
    if (!cal) {
        return;
    }
    var el = cal.activeDiv;
    var target = Calendar.getTargetElement(ev);
    if (target == el || target.parentNode == el) {
        Calendar.addClass(el, "hilite active");
        Calendar.addClass(el.parentNode, "rowhilite");
    } else {
        if (typeof el.navtype == "undefined" || (el.navtype != 50 && (el.navtype == 0 || Math.abs(el.navtype) > 2)))
            Calendar.removeClass(el, "active");
        Calendar.removeClass(el, "hilite");
        Calendar.removeClass(el.parentNode, "rowhilite");
    }
    ev || (ev = window.event);
    if (el.navtype == 50 && target != el) {
        var pos = Calendar.getAbsolutePos(el);
        var w = el.offsetWidth;
        var x = ev.clientX;
        var dx;
        var decrease = true;
        if (x > pos.x + w) {
            dx = x - pos.x - w;
            decrease = false;
        } else
            dx = pos.x - x;
        if (dx < 0)
            dx = 0;
        var range = el._range;
        var current = el._current;
        var count = Math.floor(dx / 10) % range.length;
        for (var i = range.length; --i >= 0; )
            if (range[i] == current)
                break;
        while (count-- > 0)
            if (decrease) {
                if (--i < 0)
                    i = range.length - 1;
            } else if (++i >= range.length)
                i = 0;
        var newval = range[i];
        el.innerHTML = newval;
        cal.onUpdateTime();
    }
    var mon = Calendar.findMonth(target);
    if (mon) {
        if (mon.month != cal.date.getMonth()) {
            if (cal.hilitedMonth) {
                Calendar.removeClass(cal.hilitedMonth, "hilite");
            }
            Calendar.addClass(mon, "hilite");
            cal.hilitedMonth = mon;
        } else if (cal.hilitedMonth) {
            Calendar.removeClass(cal.hilitedMonth, "hilite");
        }
    } else {
        if (cal.hilitedMonth) {
            Calendar.removeClass(cal.hilitedMonth, "hilite");
        }
        var year = Calendar.findYear(target);
        if (year) {
            if (year.year != cal.date.getFullYear()) {
                if (cal.hilitedYear) {
                    Calendar.removeClass(cal.hilitedYear, "hilite");
                }
                Calendar.addClass(year, "hilite");
                cal.hilitedYear = year;
            } else if (cal.hilitedYear) {
                Calendar.removeClass(cal.hilitedYear, "hilite");
            }
        } else if (cal.hilitedYear) {
            Calendar.removeClass(cal.hilitedYear, "hilite");
        }
    }
    return Calendar.stopEvent(ev);
};
Calendar.tableMouseDown = function(ev) {
    if (Calendar.getTargetElement(ev) == Calendar.getElement(ev)) {
        return Calendar.stopEvent(ev);
    }
};
Calendar.calDragIt = function(ev) {
    var cal = Calendar._C;
    if (!(cal && cal.dragging)) {
        return false;
    }
    var posX;
    var posY;
    if (Calendar.is_ie) {
        posY = window.event.clientY + document.body.scrollTop;
        posX = window.event.clientX + document.body.scrollLeft;
    } else {
        posX = ev.pageX;
        posY = ev.pageY;
    }
    cal.hideShowCovered();
    var st = cal.element.style;
    st.left = (posX - cal.xOffs) + "px";
    st.top = (posY - cal.yOffs) + "px";
    return Calendar.stopEvent(ev);
};
Calendar.calDragEnd = function(ev) {
    var cal = Calendar._C;
    if (!cal) {
        return false;
    }
    cal.dragging = false;
    with (Calendar) {
        removeEvent(document, "mousemove", calDragIt);
        removeEvent(document, "mouseup", calDragEnd);
        tableMouseUp(ev);
    }
    cal.hideShowCovered();
};
Calendar.dayMouseDown = function(ev) {
    var el = Calendar.getElement(ev);
    if (el.disabled) {
        return false;
    }
    var cal = el.calendar;
    cal.activeDiv = el;
    Calendar._C = cal;
    if (el.navtype != 300)
        with (Calendar) {
            if (el.navtype == 50) {
                el._current = el.innerHTML;
                addEvent(document, "mousemove", tableMouseOver);
            } else
                addEvent(document, Calendar.is_ie5 ? "mousemove" : "mouseover", tableMouseOver);
            addClass(el, "hilite active");
            addEvent(document, "mouseup", tableMouseUp);
        }
    else if (cal.isPopup) {
        cal._dragStart(ev);
    }
    if (el.navtype == -1 || el.navtype == 1) {
        if (cal.timeout)
            clearTimeout(cal.timeout);
        cal.timeout = setTimeout("Calendar.showMonthsCombo()", 250);
    } else if (el.navtype == -2 || el.navtype == 2) {
        if (cal.timeout)
            clearTimeout(cal.timeout);
        cal.timeout = setTimeout((el.navtype > 0) ? "Calendar.showYearsCombo(true)" : "Calendar.showYearsCombo(false)", 250);
    } else {
        cal.timeout = null;
    }
    return Calendar.stopEvent(ev);
};
Calendar.dayMouseDblClick = function(ev) {
    Calendar.cellClick(Calendar.getElement(ev), ev || window.event);
    if (Calendar.is_ie) {
        document.selection.empty();
    }
};
Calendar.dayMouseOver = function(ev) {
    var el = Calendar.getElement(ev);
    if (Calendar.isRelated(el, ev) || Calendar._C || el.disabled) {
        return false;
    }
    if (el.ttip) {
        if (el.ttip.substr(0, 1) == "_") {
            el.ttip = el.caldate.print(el.calendar.ttDateFormat) + el.ttip.substr(1);
        }
        el.calendar.tooltips.innerHTML = el.ttip;
    }
    if (el.navtype != 300) {
        Calendar.addClass(el, "hilite");
        if (el.caldate) {
            Calendar.addClass(el.parentNode, "rowhilite");
        }
    }
    return Calendar.stopEvent(ev);
};
Calendar.dayMouseOut = function(ev) {
    with (Calendar) {
        var el = getElement(ev);
        if (isRelated(el, ev) || _C || el.disabled)
            return false;
        removeClass(el, "hilite");
        if (el.caldate)
            removeClass(el.parentNode, "rowhilite");
        if (el.calendar)
            el.calendar.tooltips.innerHTML = _TT["SEL_DATE"];
        return stopEvent(ev);
    }
};
Calendar.cellClick = function(el, ev) {
    var cal = el.calendar;
    var closing = false;
    var newdate = false;
    var date = null;
    if (typeof el.navtype == "undefined") {
        if (cal.currentDateEl) {
            Calendar.removeClass(cal.currentDateEl, "selected");
            Calendar.addClass(el, "selected");
            closing = (cal.currentDateEl == el);
            if (!closing) {
                cal.currentDateEl = el;
            }
        }
        cal.date.setDateOnly(el.caldate);
        date = cal.date;
        var other_month = !(cal.dateClicked = !el.otherMonth);
        if (!other_month && !cal.currentDateEl)
            cal._toggleMultipleDate(new Date(date));
        else
            newdate = !el.disabled;
        if (other_month)
            cal._init(cal.firstDayOfWeek, date);
    } else {
        if (el.navtype == 200) {
            Calendar.removeClass(el, "hilite");
            cal.callCloseHandler();
            return;
        }
        date = new Date(cal.date);
        if (el.navtype == 0)
            date.setDateOnly(new Date());
        cal.dateClicked = false;
        var year = date.getFullYear();
        var mon = date.getMonth();
        function setMonth(m) {
            var day = date.getDate();
            var max = date.getMonthDays(m);
            if (day > max) {
                date.setDate(max);
            }
            date.setMonth(m);
        }
        ;
        switch (el.navtype) {
            case 400:
                Calendar.removeClass(el, "hilite");
                var text = Calendar._TT["ABOUT"];
                if (typeof text != "undefined") {
                    text += cal.showsTime ? Calendar._TT["ABOUT_TIME"] : "";
                } else {
                    text = "Help and about box text is not translated into this language.\n" + "If you know this language and you feel generous please update\n" + "the corresponding file in \"lang\" subdir to match calendar-en.js\n" + "and send it back to <mihai_bazon@yahoo.com> to get it into the distribution  ;-)\n\n" + "Thank you!\n" + "http://dynarch.com/mishoo/calendar.epl\n";
                }
                alert(text);
                return;
            case -2:
                if (year > cal.minYear) {
                    date.setFullYear(year - 1);
                }
                break;
            case -1:
                if (mon > 0) {
                    setMonth(mon - 1);
                } else if (year-- > cal.minYear) {
                    date.setFullYear(year);
                    setMonth(11);
                }
                break;
            case 1:
                if (mon < 11) {
                    setMonth(mon + 1);
                } else if (year < cal.maxYear) {
                    date.setFullYear(year + 1);
                    setMonth(0);
                }
                break;
            case 2:
                if (year < cal.maxYear) {
                    date.setFullYear(year + 1);
                }
                break;
            case 100:
                cal.setFirstDayOfWeek(el.fdow);
                return;
            case 50:
                var range = el._range;
                var current = el.innerHTML;
                for (var i = range.length; --i >= 0; )
                    if (range[i] == current)
                        break;
                if (ev && ev.shiftKey) {
                    if (--i < 0)
                        i = range.length - 1;
                } else if (++i >= range.length)
                    i = 0;
                var newval = range[i];
                el.innerHTML = newval;
                cal.onUpdateTime();
                return;
            case 0:
                if ((typeof cal.getDateStatus == "function") && cal.getDateStatus(date, date.getFullYear(), date.getMonth(), date.getDate())) {
                    return false;
                }
                break;
        }
        if (!date.equalsTo(cal.date)) {
            cal.setDate(date);
            newdate = true;
        } else if (el.navtype == 0)
            newdate = closing = true;
    }
    if (newdate) {
        ev && cal.callHandler();
    }
    if (closing) {
        Calendar.removeClass(el, "hilite");
        ev && cal.callCloseHandler();
    }
};
Calendar.prototype.create = function(_par) {
    var parent = null;
    if (!_par) {
        parent = document.getElementsByTagName("body")[0];
        this.isPopup = true;
    } else {
        parent = _par;
        this.isPopup = false;
    }
    this.date = this.dateStr ? new Date(this.dateStr) : new Date();
    var table = Calendar.createElement("table");
    this.table = table;
    table.cellSpacing = 0;
    table.cellPadding = 0;
    table.calendar = this;
    Calendar.addEvent(table, "mousedown", Calendar.tableMouseDown);
    var div = Calendar.createElement("div");
    this.element = div;
    div.className = "calendar";
    if (this.isPopup) {
        div.style.position = "absolute";
        div.style.display = "none";
    }
    div.appendChild(table);
    var thead = Calendar.createElement("thead", table);
    var cell = null;
    var row = null;
    var cal = this;
    var hh = function(text, cs, navtype) {
        cell = Calendar.createElement("td", row);
        cell.colSpan = cs;
        cell.className = "button";
        if (navtype != 0 && Math.abs(navtype) <= 2)
            cell.className += " nav";
        Calendar._add_evs(cell);
        cell.calendar = cal;
        cell.navtype = navtype;
        cell.innerHTML = "<div unselectable='on'>" + text + "</div>";
        return cell;
    };
    row = Calendar.createElement("tr", thead);
    var title_length = 6;
    (this.isPopup) && --title_length;
    (this.weekNumbers) && ++title_length;
    hh("?", 1, 400).ttip = Calendar._TT["INFO"];
    this.title = hh("", title_length, 300);
    this.title.className = "title";
    if (this.isPopup) {
        this.title.ttip = Calendar._TT["DRAG_TO_MOVE"];
        this.title.style.cursor = "move";
        hh("&#x00d7;", 1, 200).ttip = Calendar._TT["CLOSE"];
    }
    row = Calendar.createElement("tr", thead);
    row.className = "headrow";
    this._nav_py = hh("&#x00ab;", 1, -2);
    this._nav_py.ttip = Calendar._TT["PREV_YEAR"];
    this._nav_pm = hh("&#x2039;", 1, -1);
    this._nav_pm.ttip = Calendar._TT["PREV_MONTH"];
    this._nav_now = hh(Calendar._TT["TODAY"], this.weekNumbers ? 4 : 3, 0);
    this._nav_now.ttip = Calendar._TT["GO_TODAY"];
    this._nav_nm = hh("&#x203a;", 1, 1);
    this._nav_nm.ttip = Calendar._TT["NEXT_MONTH"];
    this._nav_ny = hh("&#x00bb;", 1, 2);
    this._nav_ny.ttip = Calendar._TT["NEXT_YEAR"];
    row = Calendar.createElement("tr", thead);
    row.className = "daynames";
    if (this.weekNumbers) {
        cell = Calendar.createElement("td", row);
        cell.className = "name wn";
        cell.innerHTML = Calendar._TT["WK"];
    }
    for (var i = 7; i > 0; --i) {
        cell = Calendar.createElement("td", row);
        if (!i) {
            cell.navtype = 100;
            cell.calendar = this;
            Calendar._add_evs(cell);
        }
    }
    this.firstdayname = (this.weekNumbers) ? row.firstChild.nextSibling : row.firstChild;
    this._displayWeekdays();
    var tbody = Calendar.createElement("tbody", table);
    this.tbody = tbody;
    for (i = 6; i > 0; --i) {
        row = Calendar.createElement("tr", tbody);
        if (this.weekNumbers) {
            cell = Calendar.createElement("td", row);
        }
        for (var j = 7; j > 0; --j) {
            cell = Calendar.createElement("td", row);
            cell.calendar = this;
            Calendar._add_evs(cell);
        }
    }
    if (this.showsTime) {
        row = Calendar.createElement("tr", tbody);
        row.className = "time";
        cell = Calendar.createElement("td", row);
        cell.className = "time";
        cell.colSpan = 2;
        cell.innerHTML = Calendar._TT["TIME"] || "&nbsp;";
        cell = Calendar.createElement("td", row);
        cell.className = "time";
        cell.colSpan = this.weekNumbers ? 4 : 3;
        (function() {
            function makeTimePart(className, init, range_start, range_end) {
                var part = Calendar.createElement("span", cell);
                part.className = className;
                part.innerHTML = init;
                part.calendar = cal;
                part.ttip = Calendar._TT["TIME_PART"];
                part.navtype = 50;
                part._range = [];
                if (typeof range_start != "number")
                    part._range = range_start;
                else {
                    for (var i = range_start; i <= range_end; ++i) {
                        var txt;
                        if (i < 10 && range_end >= 10)
                            txt = '0' + i;
                        else
                            txt = '' + i;
                        part._range[part._range.length] = txt;
                    }
                }
                Calendar._add_evs(part);
                return part;
            }
            ;
            var hrs = cal.date.getHours();
            var mins = cal.date.getMinutes();
            var t12 = !cal.time24;
            var pm = (hrs > 12);
            if (t12 && pm)
                hrs -= 12;
            var H = makeTimePart("hour", hrs, t12 ? 1 : 0, t12 ? 12 : 23);
            var span = Calendar.createElement("span", cell);
            span.innerHTML = ":";
            span.className = "colon";
            var M = makeTimePart("minute", mins, 0, 59);
            var AP = null;
            cell = Calendar.createElement("td", row);
            cell.className = "time";
            cell.colSpan = 2;
            if (t12)
                AP = makeTimePart("ampm", pm ? "pm" : "am", ["am", "pm"]);
            else
                cell.innerHTML = "&nbsp;";
            cal.onSetTime = function() {
                var pm, hrs = this.date.getHours(), mins = this.date.getMinutes();
                if (t12) {
                    pm = (hrs >= 12);
                    if (pm)
                        hrs -= 12;
                    if (hrs == 0)
                        hrs = 12;
                    AP.innerHTML = pm ? "pm" : "am";
                }
                H.innerHTML = (hrs < 10) ? ("0" + hrs) : hrs;
                M.innerHTML = (mins < 10) ? ("0" + mins) : mins;
            };
            cal.onUpdateTime = function() {
                var date = this.date;
                var h = parseInt(H.innerHTML, 10);
                if (t12) {
                    if (/pm/i.test(AP.innerHTML) && h < 12)
                        h += 12;
                    else if (/am/i.test(AP.innerHTML) && h == 12)
                        h = 0;
                }
                var d = date.getDate();
                var m = date.getMonth();
                var y = date.getFullYear();
                date.setHours(h);
                date.setMinutes(parseInt(M.innerHTML, 10));
                date.setFullYear(y);
                date.setMonth(m);
                date.setDate(d);
                this.dateClicked = false;
                this.callHandler();
            };
        })();
    } else {
        this.onSetTime = this.onUpdateTime = function() {
        };
    }
    var tfoot = Calendar.createElement("tfoot", table);
    row = Calendar.createElement("tr", tfoot);
    row.className = "footrow";
    cell = hh(Calendar._TT["SEL_DATE"], this.weekNumbers ? 8 : 7, 300);
    cell.className = "ttip";
    if (this.isPopup) {
        cell.ttip = Calendar._TT["DRAG_TO_MOVE"];
        cell.style.cursor = "move";
    }
    this.tooltips = cell;
    div = Calendar.createElement("div", this.element);
    this.monthsCombo = div;
    div.className = "combo";
    for (i = 0; i < Calendar._MN.length; ++i) {
        var mn = Calendar.createElement("div");
        mn.className = Calendar.is_ie ? "label-IEfix" : "label";
        mn.month = i;
        mn.innerHTML = Calendar._SMN[i];
        div.appendChild(mn);
    }
    div = Calendar.createElement("div", this.element);
    this.yearsCombo = div;
    div.className = "combo";
    for (i = 12; i > 0; --i) {
        var yr = Calendar.createElement("div");
        yr.className = Calendar.is_ie ? "label-IEfix" : "label";
        div.appendChild(yr);
    }
    this._init(this.firstDayOfWeek, this.date);
    parent.appendChild(this.element);
};
Calendar._keyEvent = function(ev) {
    var cal = window._dynarch_popupCalendar;
    if (!cal || cal.multiple)
        return false;
    (Calendar.is_ie) && (ev = window.event);
    var act = (Calendar.is_ie || ev.type == "keypress"), K = ev.keyCode;
    if (ev.ctrlKey) {
        switch (K) {
            case 37:
                act && Calendar.cellClick(cal._nav_pm);
                break;
            case 38:
                act && Calendar.cellClick(cal._nav_py);
                break;
            case 39:
                act && Calendar.cellClick(cal._nav_nm);
                break;
            case 40:
                act && Calendar.cellClick(cal._nav_ny);
                break;
            default:
                return false;
        }
    } else
        switch (K) {
            case 32:
                Calendar.cellClick(cal._nav_now);
                break;
            case 27:
                act && cal.callCloseHandler();
                break;
            case 37:
            case 38:
            case 39:
            case 40:
                if (act) {
                    var prev, x, y, ne, el, step;
                    prev = K == 37 || K == 38;
                    step = (K == 37 || K == 39) ? 1 : 7;
                    function setVars() {
                        el = cal.currentDateEl;
                        var p = el.pos;
                        x = p & 15;
                        y = p >> 4;
                        ne = cal.ar_days[y][x];
                    }
                    ;
                    setVars();
                    function prevMonth() {
                        var date = new Date(cal.date);
                        date.setDate(date.getDate() - step);
                        cal.setDate(date);
                    }
                    ;
                    function nextMonth() {
                        var date = new Date(cal.date);
                        date.setDate(date.getDate() + step);
                        cal.setDate(date);
                    }
                    ;
                    while (1) {
                        switch (K) {
                            case 37:
                                if (--x >= 0)
                                    ne = cal.ar_days[y][x];
                                else {
                                    x = 6;
                                    K = 38;
                                    continue;
                                }
                                break;
                            case 38:
                                if (--y >= 0)
                                    ne = cal.ar_days[y][x];
                                else {
                                    prevMonth();
                                    setVars();
                                }
                                break;
                            case 39:
                                if (++x < 7)
                                    ne = cal.ar_days[y][x];
                                else {
                                    x = 0;
                                    K = 40;
                                    continue;
                                }
                                break;
                            case 40:
                                if (++y < cal.ar_days.length)
                                    ne = cal.ar_days[y][x];
                                else {
                                    nextMonth();
                                    setVars();
                                }
                                break;
                        }
                        break;
                    }
                    if (ne) {
                        if (!ne.disabled)
                            Calendar.cellClick(ne);
                        else if (prev)
                            prevMonth();
                        else
                            nextMonth();
                    }
                }
                break;
            case 13:
                if (act)
                    Calendar.cellClick(cal.currentDateEl, ev);
                break;
            default:
                return false;
        }
    return Calendar.stopEvent(ev);
};
Calendar.prototype._init = function(firstDayOfWeek, date) {
    var today = new Date(), TY = today.getFullYear(), TM = today.getMonth(), TD = today.getDate();
    this.table.style.visibility = "hidden";
    var year = date.getFullYear();
    if (year < this.minYear) {
        year = this.minYear;
        date.setFullYear(year);
    } else if (year > this.maxYear) {
        year = this.maxYear;
        date.setFullYear(year);
    }
    this.firstDayOfWeek = firstDayOfWeek;
    this.date = new Date(date);
    var month = date.getMonth();
    var mday = date.getDate();
    var no_days = date.getMonthDays();
    date.setDate(1);
    var day1 = (date.getDay() - this.firstDayOfWeek) % 7;
    if (day1 < 0)
        day1 += 7;
    date.setDate(-day1);
    date.setDate(date.getDate() + 1);
    var row = this.tbody.firstChild;
    var MN = Calendar._SMN[month];
    var ar_days = this.ar_days = new Array();
    var weekend = Calendar._TT["WEEKEND"];
    var dates = this.multiple ? (this.datesCells = {}) : null;
    for (var i = 0; i < 6; ++i, row = row.nextSibling) {
        var cell = row.firstChild;
        if (this.weekNumbers) {
            cell.className = "day wn";
            cell.innerHTML = date.getWeekNumber();
            cell = cell.nextSibling;
        }
        row.className = "daysrow";
        var hasdays = false, iday, dpos = ar_days[i] = [];
        for (var j = 0; j < 7; ++j, cell = cell.nextSibling, date.setDate(iday + 1)) {
            iday = date.getDate();
            var wday = date.getDay();
            cell.className = "day";
            cell.pos = i << 4 | j;
            dpos[j] = cell;
            var current_month = (date.getMonth() == month);
            if (!current_month) {
                if (this.showsOtherMonths) {
                    cell.className += " othermonth";
                    cell.otherMonth = true;
                } else {
                    cell.className = "emptycell";
                    cell.innerHTML = "&nbsp;";
                    cell.disabled = true;
                    continue;
                }
            } else {
                cell.otherMonth = false;
                hasdays = true;
            }
            cell.disabled = false;
            cell.innerHTML = this.getDateText ? this.getDateText(date, iday) : iday;
            if (dates)
                dates[date.print("%Y%m%d")] = cell;
            if (this.getDateStatus) {
                var status = this.getDateStatus(date, year, month, iday);
                if (this.getDateToolTip) {
                    var toolTip = this.getDateToolTip(date, year, month, iday);
                    if (toolTip)
                        cell.title = toolTip;
                }
                if (status === true) {
                    cell.className += " disabled";
                    cell.disabled = true;
                } else {
                    if (/disabled/i.test(status))
                        cell.disabled = true;
                    cell.className += " " + status;
                }
            }
            if (!cell.disabled) {
                cell.caldate = new Date(date);
                cell.ttip = "_";
                if (!this.multiple && current_month && iday == mday && this.hiliteToday) {
                    cell.className += " selected";
                    this.currentDateEl = cell;
                }
                if (date.getFullYear() == TY && date.getMonth() == TM && iday == TD) {
                    cell.className += " today";
                    cell.ttip += Calendar._TT["PART_TODAY"];
                }
                if (weekend.indexOf(wday.toString()) != -1)
                    cell.className += cell.otherMonth ? " oweekend" : " weekend";
            }
        }
        if (!(hasdays || this.showsOtherMonths))
            row.className = "emptyrow";
    }
    this.title.innerHTML = Calendar._MN[month] + ", " + year;
    this.onSetTime();
    this.table.style.visibility = "visible";
    this._initMultipleDates();
};
Calendar.prototype._initMultipleDates = function() {
    if (this.multiple) {
        for (var i in this.multiple) {
            var cell = this.datesCells[i];
            var d = this.multiple[i];
            if (!d)
                continue;
            if (cell)
                cell.className += " selected";
        }
    }
};
Calendar.prototype._toggleMultipleDate = function(date) {
    if (this.multiple) {
        var ds = date.print("%Y%m%d");
        var cell = this.datesCells[ds];
        if (cell) {
            var d = this.multiple[ds];
            if (!d) {
                Calendar.addClass(cell, "selected");
                this.multiple[ds] = date;
            } else {
                Calendar.removeClass(cell, "selected");
                delete this.multiple[ds];
            }
        }
    }
};
Calendar.prototype.setDateToolTipHandler = function(unaryFunction) {
    this.getDateToolTip = unaryFunction;
};
Calendar.prototype.setDate = function(date) {
    if (!date.equalsTo(this.date)) {
        this._init(this.firstDayOfWeek, date);
    }
};
Calendar.prototype.refresh = function() {
    this._init(this.firstDayOfWeek, this.date);
};
Calendar.prototype.setFirstDayOfWeek = function(firstDayOfWeek) {
    this._init(firstDayOfWeek, this.date);
    this._displayWeekdays();
};
Calendar.prototype.setDateStatusHandler = Calendar.prototype.setDisabledHandler = function(unaryFunction) {
    this.getDateStatus = unaryFunction;
};
Calendar.prototype.setRange = function(a, z) {
    this.minYear = a;
    this.maxYear = z;
};
Calendar.prototype.callHandler = function() {
    if (this.onSelected) {
        this.onSelected(this, this.date.print(this.dateFormat));
    }
};
Calendar.prototype.callCloseHandler = function() {
    if (this.onClose) {
        this.onClose(this);
    }
    this.hideShowCovered();
};
Calendar.prototype.destroy = function() {
    var el = this.element.parentNode;
    el.removeChild(this.element);
    Calendar._C = null;
    window._dynarch_popupCalendar = null;
};
Calendar.prototype.reparent = function(new_parent) {
    var el = this.element;
    el.parentNode.removeChild(el);
    new_parent.appendChild(el);
};
Calendar._checkCalendar = function(ev) {
    var calendar = window._dynarch_popupCalendar;
    if (!calendar) {
        return false;
    }
    var el = Calendar.is_ie ? Calendar.getElement(ev) : Calendar.getTargetElement(ev);
    for (; el != null && el != calendar.element; el = el.parentNode)
        ;
    if (el == null) {
        window._dynarch_popupCalendar.callCloseHandler();
        return Calendar.stopEvent(ev);
    }
};
Calendar.prototype.show = function() {
    var rows = this.table.getElementsByTagName("tr");
    for (var i = rows.length; i > 0; ) {
        var row = rows[--i];
        Calendar.removeClass(row, "rowhilite");
        var cells = row.getElementsByTagName("td");
        for (var j = cells.length; j > 0; ) {
            var cell = cells[--j];
            Calendar.removeClass(cell, "hilite");
            Calendar.removeClass(cell, "active");
        }
    }
    this.element.style.display = "block";
    this.hidden = false;
    if (this.isPopup) {
        window._dynarch_popupCalendar = this;
        Calendar.addEvent(document, "keydown", Calendar._keyEvent);
        Calendar.addEvent(document, "keypress", Calendar._keyEvent);
        Calendar.addEvent(document, "mousedown", Calendar._checkCalendar);
    }
    this.hideShowCovered();
};
Calendar.prototype.hide = function() {
    if (this.isPopup) {
        Calendar.removeEvent(document, "keydown", Calendar._keyEvent);
        Calendar.removeEvent(document, "keypress", Calendar._keyEvent);
        Calendar.removeEvent(document, "mousedown", Calendar._checkCalendar);
    }
    this.element.style.display = "none";
    this.hidden = true;
    this.hideShowCovered();
};
Calendar.prototype.showAt = function(x, y) {
    var s = this.element.style;
    s.left = x + "px";
    s.top = y + "px";
    this.show();
};
Calendar.prototype.showAtElement = function(el, opts) {
    var self = this;
    var p = Calendar.getAbsolutePos(el);
    if (!opts || typeof opts != "string") {
        this.showAt(p.x, p.y + el.offsetHeight);
        return true;
    }
    function fixPosition(box) {
        if (box.x < 0)
            box.x = 0;
        if (box.y < 0)
            box.y = 0;
        var cp = document.createElement("div");
        var s = cp.style;
        s.position = "absolute";
        s.right = s.bottom = s.width = s.height = "0px";
        document.body.appendChild(cp);
        var br = Calendar.getAbsolutePos(cp);
        document.body.removeChild(cp);
        if (Calendar.is_ie) {
            br.y += document.body.scrollTop;
            br.x += document.body.scrollLeft;
        } else {
            br.y += window.scrollY;
            br.x += window.scrollX;
        }
        var tmp = box.x + box.width - br.x;
        if (tmp > 0)
            box.x -= tmp;
        tmp = box.y + box.height - br.y;
        if (tmp > 0)
            box.y -= tmp;
    }
    ;
    this.element.style.display = "block";
    Calendar.continuation_for_the_fucking_khtml_browser = function() {
        var w = self.element.offsetWidth;
        var h = self.element.offsetHeight;
        self.element.style.display = "none";
        var valign = opts.substr(0, 1);
        var halign = "l";
        if (opts.length > 1) {
            halign = opts.substr(1, 1);
        }
        switch (valign) {
            case "T":
                p.y -= h;
                break;
            case "B":
                p.y += el.offsetHeight;
                break;
            case "C":
                p.y += (el.offsetHeight - h) / 2;
                break;
            case "t":
                p.y += el.offsetHeight - h;
                break;
            case "b":
                break;
        }
        switch (halign) {
            case "L":
                p.x -= w;
                break;
            case "R":
                p.x += el.offsetWidth;
                break;
            case "C":
                p.x += (el.offsetWidth - w) / 2;
                break;
            case "l":
                p.x += el.offsetWidth - w;
                break;
            case "r":
                break;
        }
        p.width = w;
        p.height = h + 40;
        self.monthsCombo.style.display = "none";
        fixPosition(p);
        self.showAt(p.x, p.y);
    };
    if (Calendar.is_khtml)
        setTimeout("Calendar.continuation_for_the_fucking_khtml_browser()", 10);
    else
        Calendar.continuation_for_the_fucking_khtml_browser();
};
Calendar.prototype.setDateFormat = function(str) {
    this.dateFormat = str;
};
Calendar.prototype.setTtDateFormat = function(str) {
    this.ttDateFormat = str;
};
Calendar.prototype.parseDate = function(str, fmt) {
    if (!fmt)
        fmt = this.dateFormat;
    this.setDate(Date.parseDate(str, fmt));
};
Calendar.prototype.hideShowCovered = function() {
    if (!Calendar.is_ie && !Calendar.is_opera)
        return;
    function getVisib(obj) {
        var value = obj.style.visibility;
        if (!value) {
            if (document.defaultView && typeof (document.defaultView.getComputedStyle) == "function") {
                if (!Calendar.is_khtml)
                    value = document.defaultView.getComputedStyle(obj, "").getPropertyValue("visibility");
                else
                    value = '';
            } else if (obj.currentStyle) {
                value = obj.currentStyle.visibility;
            } else
                value = '';
        }
        return value;
    }
    ;
    var tags = new Array("applet", "iframe", "select");
    var el = this.element;
    var p = Calendar.getAbsolutePos(el);
    var EX1 = p.x;
    var EX2 = el.offsetWidth + EX1;
    var EY1 = p.y;
    var EY2 = el.offsetHeight + EY1;
    for (var k = tags.length; k > 0; ) {
        var ar = document.getElementsByTagName(tags[--k]);
        var cc = null;
        for (var i = ar.length; i > 0; ) {
            cc = ar[--i];
            p = Calendar.getAbsolutePos(cc);
            var CX1 = p.x;
            var CX2 = cc.offsetWidth + CX1;
            var CY1 = p.y;
            var CY2 = cc.offsetHeight + CY1;
            if (this.hidden || (CX1 > EX2) || (CX2 < EX1) || (CY1 > EY2) || (CY2 < EY1)) {
                if (!cc.__msh_save_visibility) {
                    cc.__msh_save_visibility = getVisib(cc);
                }
                cc.style.visibility = cc.__msh_save_visibility;
            } else {
                if (!cc.__msh_save_visibility) {
                    cc.__msh_save_visibility = getVisib(cc);
                }
                cc.style.visibility = "hidden";
            }
        }
    }
};
Calendar.prototype._displayWeekdays = function() {
    var fdow = this.firstDayOfWeek;
    var cell = this.firstdayname;
    var weekend = Calendar._TT["WEEKEND"];
    for (var i = 0; i < 7; ++i) {
        cell.className = "day name";
        var realday = (i + fdow) % 7;
        if (i) {
            cell.ttip = Calendar._TT["DAY_FIRST"].replace("%s", Calendar._DN[realday]);
            cell.navtype = 100;
            cell.calendar = this;
            cell.fdow = realday;
            Calendar._add_evs(cell);
        }
        if (weekend.indexOf(realday.toString()) != -1) {
            Calendar.addClass(cell, "weekend");
        }
        cell.innerHTML = Calendar._SDN[(i + fdow) % 7];
        cell = cell.nextSibling;
    }
};
Calendar.prototype._hideCombos = function() {
    this.monthsCombo.style.display = "none";
    this.yearsCombo.style.display = "none";
};
Calendar.prototype._dragStart = function(ev) {
    if (this.dragging) {
        return;
    }
    this.dragging = true;
    var posX;
    var posY;
    if (Calendar.is_ie) {
        posY = window.event.clientY + document.body.scrollTop;
        posX = window.event.clientX + document.body.scrollLeft;
    } else {
        posY = ev.clientY + window.scrollY;
        posX = ev.clientX + window.scrollX;
    }
    var st = this.element.style;
    this.xOffs = posX - parseInt(st.left);
    this.yOffs = posY - parseInt(st.top);
    with (Calendar) {
        addEvent(document, "mousemove", calDragIt);
        addEvent(document, "mouseup", calDragEnd);
    }
};
Date._MD = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
Date.SECOND = 1000;
Date.MINUTE = 60 * Date.SECOND;
Date.HOUR = 60 * Date.MINUTE;
Date.DAY = 24 * Date.HOUR;
Date.WEEK = 7 * Date.DAY;
Date.parseDate = function(str, fmt) {
    var today = new Date();
    var y = 0;
    var m = -1;
    var d = 0;
    var a = str.split(/\W+/);
    var b = fmt.match(/%./g);
    var i = 0, j = 0;
    var hr = 0;
    var min = 0;
    for (i = 0; i < a.length; ++i) {
        if (!a[i])
            continue;
        switch (b[i]) {
            case "%d":
            case "%e":
                d = parseInt(a[i], 10);
                break;
            case "%m":
                m = parseInt(a[i], 10) - 1;
                break;
            case "%Y":
            case "%y":
                y = parseInt(a[i], 10);
                (y < 100) && (y += (y > 29) ? 1900 : 2000);
                break;
            case "%b":
            case "%B":
                for (j = 0; j < 12; ++j) {
                    if (Calendar._MN[j].substr(0, a[i].length).toLowerCase() == a[i].toLowerCase()) {
                        m = j;
                        break;
                    }
                }
                break;
            case "%H":
            case "%I":
            case "%k":
            case "%l":
                hr = parseInt(a[i], 10);
                break;
            case "%P":
            case "%p":
                if (/pm/i.test(a[i]) && hr < 12)
                    hr += 12;
                else if (/am/i.test(a[i]) && hr >= 12)
                    hr -= 12;
                break;
            case "%M":
                min = parseInt(a[i], 10);
                break;
        }
    }
    if (isNaN(y))
        y = today.getFullYear();
    if (isNaN(m))
        m = today.getMonth();
    if (isNaN(d))
        d = today.getDate();
    if (isNaN(hr))
        hr = today.getHours();
    if (isNaN(min))
        min = today.getMinutes();
    if (y != 0 && m != -1 && d != 0)
        return new Date(y, m, d, hr, min, 0);
    y = 0;
    m = -1;
    d = 0;
    for (i = 0; i < a.length; ++i) {
        if (a[i].search(/[a-zA-Z]+/) != -1) {
            var t = -1;
            for (j = 0; j < 12; ++j) {
                if (Calendar._MN[j].substr(0, a[i].length).toLowerCase() == a[i].toLowerCase()) {
                    t = j;
                    break;
                }
            }
            if (t != -1) {
                if (m != -1) {
                    d = m + 1;
                }
                m = t;
            }
        } else if (parseInt(a[i], 10) <= 12 && m == -1) {
            m = a[i] - 1;
        } else if (parseInt(a[i], 10) > 31 && y == 0) {
            y = parseInt(a[i], 10);
            (y < 100) && (y += (y > 29) ? 1900 : 2000);
        } else if (d == 0) {
            d = a[i];
        }
    }
    if (y == 0)
        y = today.getFullYear();
    if (m != -1 && d != 0)
        return new Date(y, m, d, hr, min, 0);
    return today;
};
Date.prototype.getMonthDays = function(month) {
    var year = this.getFullYear();
    if (typeof month == "undefined") {
        month = this.getMonth();
    }
    if (((0 == (year % 4)) && ((0 != (year % 100)) || (0 == (year % 400)))) && month == 1) {
        return 29;
    } else {
        return Date._MD[month];
    }
};
Date.prototype.getDayOfYear = function() {
    var now = new Date(this.getFullYear(), this.getMonth(), this.getDate(), 0, 0, 0);
    var then = new Date(this.getFullYear(), 0, 0, 0, 0, 0);
    var time = now - then;
    return Math.floor(time / Date.DAY);
};
Date.prototype.getWeekNumber = function() {
    var d = new Date(this.getFullYear(), this.getMonth(), this.getDate(), 0, 0, 0);
    var DoW = d.getDay();
    d.setDate(d.getDate() - (DoW + 6) % 7 + 3);
    var ms = d.valueOf();
    d.setMonth(0);
    d.setDate(4);
    return Math.round((ms - d.valueOf()) / (7 * 864e5)) + 1;
};
Date.prototype.equalsTo = function(date) {
    return ((this.getFullYear() == date.getFullYear()) && (this.getMonth() == date.getMonth()) && (this.getDate() == date.getDate()) && (this.getHours() == date.getHours()) && (this.getMinutes() == date.getMinutes()));
};
Date.prototype.setDateOnly = function(date) {
    var tmp = new Date(date);
    this.setDate(1);
    this.setFullYear(tmp.getFullYear());
    this.setMonth(tmp.getMonth());
    this.setDate(tmp.getDate());
};
Date.prototype.print = function(str) {
    var m = this.getMonth();
    var d = this.getDate();
    var y = this.getFullYear();
    var wn = this.getWeekNumber();
    var w = this.getDay();
    var s = {};
    var hr = this.getHours();
    var pm = (hr >= 12);
    var ir = (pm) ? (hr - 12) : hr;
    var dy = this.getDayOfYear();
    if (ir == 0)
        ir = 12;
    var min = this.getMinutes();
    var sec = this.getSeconds();
    s["%a"] = Calendar._SDN[w];
    s["%A"] = Calendar._DN[w];
    s["%b"] = Calendar._SMN[m];
    s["%B"] = Calendar._MN[m];
    s["%C"] = 1 + Math.floor(y / 100);
    s["%d"] = (d < 10) ? ("0" + d) : d;
    s["%e"] = d;
    s["%H"] = (hr < 10) ? ("0" + hr) : hr;
    s["%I"] = (ir < 10) ? ("0" + ir) : ir;
    s["%j"] = (dy < 100) ? ((dy < 10) ? ("00" + dy) : ("0" + dy)) : dy;
    s["%k"] = hr;
    s["%l"] = ir;
    s["%m"] = (m < 9) ? ("0" + (1 + m)) : (1 + m);
    s["%M"] = (min < 10) ? ("0" + min) : min;
    s["%n"] = "\n";
    s["%p"] = pm ? "PM" : "AM";
    s["%P"] = pm ? "pm" : "am";
    s["%s"] = Math.floor(this.getTime() / 1000);
    s["%S"] = (sec < 10) ? ("0" + sec) : sec;
    s["%t"] = "\t";
    s["%U"] = s["%W"] = s["%V"] = (wn < 10) ? ("0" + wn) : wn;
    s["%u"] = w + 1;
    s["%w"] = w;
    s["%y"] = ('' + y).substr(2, 2);
    s["%Y"] = y;
    s["%%"] = "%";
    var re = /%./g;
    if (!Calendar.is_ie5 && !Calendar.is_khtml)
        return str.replace(re, function(par) {
            return s[par] || par;
        });
    var a = str.match(re);
    for (var i = 0; i < a.length; i++) {
        var tmp = s[a[i]];
        if (tmp) {
            re = new RegExp(a[i], 'g');
            str = str.replace(re, tmp);
        }
    }
    return str;
};
Date.prototype.__msh_oldSetFullYear = Date.prototype.setFullYear;
Date.prototype.setFullYear = function(y) {
    var d = new Date(this);
    d.__msh_oldSetFullYear(y);
    if (d.getMonth() != this.getMonth())
        this.setDate(28);
    this.__msh_oldSetFullYear(y);
};
window._dynarch_popupCalendar = null;
Calendar.setup = function(params) {
    function param_default(pname, def) {
        if (typeof params[pname] == "undefined") {
            params[pname] = def;
        }
    }
    ;
    param_default("inputField", null);
    param_default("displayArea", null);
    param_default("button", null);
    param_default("eventName", "click");
    param_default("ifFormat", "%Y/%m/%d");
    param_default("daFormat", "%Y/%m/%d");
    param_default("singleClick", true);
    param_default("disableFunc", null);
    param_default("dateStatusFunc", params["disableFunc"]);
    param_default("dateText", null);
    param_default("firstDay", null);
    param_default("align", "Br");
    param_default("range", [1900, 2999]);
    param_default("weekNumbers", true);
    param_default("flat", null);
    param_default("flatCallback", null);
    param_default("onSelect", null);
    param_default("onClose", null);
    param_default("onUpdate", null);
    param_default("date", null);
    param_default("showsTime", false);
    param_default("timeFormat", "24");
    param_default("electric", true);
    param_default("step", 2);
    param_default("position", null);
    param_default("cache", false);
    param_default("showOthers", false);
    param_default("multiple", null);
    var tmp = ["inputField", "displayArea", "button"];
    for (var i in tmp) {
        if (typeof params[tmp[i]] == "string") {
            params[tmp[i]] = document.getElementById(params[tmp[i]]);
        }
    }
    if (!(params.flat || params.multiple || params.inputField || params.displayArea || params.button)) {
        alert("Calendar.setup:\n  Nothing to setup (no fields found).  Please check your code");
        return false;
    }
    function onSelect(cal) {
        var p = cal.params;
        var update = (cal.dateClicked || p.electric);
        if (update && p.inputField) {
            p.inputField.value = cal.date.print(p.ifFormat);
            if (typeof p.inputField.onchange == "function")
                p.inputField.onchange();
        }
        if (update && p.displayArea)
            p.displayArea.innerHTML = cal.date.print(p.daFormat);
        if (update && typeof p.onUpdate == "function")
            p.onUpdate(cal);
        if (update && p.flat) {
            if (typeof p.flatCallback == "function")
                p.flatCallback(cal);
        }
        if (update && p.singleClick && cal.dateClicked)
            cal.callCloseHandler();
    }
    ;
    if (params.flat != null) {
        if (typeof params.flat == "string")
            params.flat = document.getElementById(params.flat);
        if (!params.flat) {
            alert("Calendar.setup:\n  Flat specified but can't find parent.");
            return false;
        }
        var cal = new Calendar(params.firstDay, params.date, params.onSelect || onSelect);
        cal.showsOtherMonths = params.showOthers;
        cal.showsTime = params.showsTime;
        cal.time24 = (params.timeFormat == "24");
        cal.params = params;
        cal.weekNumbers = params.weekNumbers;
        cal.setRange(params.range[0], params.range[1]);
        cal.setDateStatusHandler(params.dateStatusFunc);
        cal.getDateText = params.dateText;
        if (params.ifFormat) {
            cal.setDateFormat(params.ifFormat);
        }
        if (params.inputField && typeof params.inputField.value == "string") {
            cal.parseDate(params.inputField.value);
        }
        cal.create(params.flat);
        cal.show();
        return false;
    }
    var triggerEl = params.button || params.displayArea || params.inputField;
    triggerEl["on" + params.eventName] = function() {
        var dateEl = params.inputField || params.displayArea;
        var dateFmt = params.inputField ? params.ifFormat : params.daFormat;
        var mustCreate = false;
        var cal = window.calendar;
        if (dateEl)
            params.date = Date.parseDate(dateEl.value || dateEl.innerHTML, dateFmt);
        if (!(cal && params.cache)) {
            window.calendar = cal = new Calendar(params.firstDay, params.date, params.onSelect || onSelect, params.onClose || function(cal) {
                cal.hide();
            });
            cal.showsTime = params.showsTime;
            cal.time24 = (params.timeFormat == "24");
            cal.weekNumbers = params.weekNumbers;
            mustCreate = true;
        } else {
            if (params.date)
                cal.setDate(params.date);
            cal.hide();
        }
        if (params.multiple) {
            cal.multiple = {};
            for (var i = params.multiple.length; --i >= 0; ) {
                var d = params.multiple[i];
                var ds = d.print("%Y%m%d");
                cal.multiple[ds] = d;
            }
        }
        cal.showsOtherMonths = params.showOthers;
        cal.yearStep = params.step;
        cal.setRange(params.range[0], params.range[1]);
        cal.params = params;
        cal.setDateStatusHandler(params.dateStatusFunc);
        cal.getDateText = params.dateText;
        cal.setDateFormat(dateFmt);
        if (mustCreate)
            cal.create();
        cal.refresh();
        if (!params.position)
            cal.showAtElement(params.button || params.displayArea || params.inputField, params.align);
        else
            cal.showAt(params.position[0], params.position[1]);
        return false;
    };
    return cal;
};
function clear_form(form_root) {
    $(form_root + " input[type=text]").each(function() {
        $(this).val("");
    });
    $(form_root + " input[type=hidden]").each(function() {
        $(this).val("");
    });
    $(form_root + " input[type=password]").each(function() {
        $(this).val("");
    });
    $(form_root + " div.date_show").each(function() {
        $(this).val("vali kuupäev");
    });
    $(form_root + " input[type=checkbox]").each(function() {
        $(this).attr("checked", false);
    })
}
function price_selected(obj) {
    var ids = obj.id.split('price_model_id_');
    var id = ids[1];
    var code_container = $("#campaign_code_container_" + id);
    var selected_option = obj.options[obj.selectedIndex];
    var is_campaign = selected_option.className == 'campaign';
    is_campaign ? code_container.show() : code_container.hide();
    $("#campaign_code_text_" + id).text(eval('price_model_description_' + selected_option.value));
}
function SeatSelector()
{
    var seat_count = 0
    var grand_waitingForActivationResponse = false;
    var area = null;
    this.set_waitingForActivationResponse = function(bool)
    {
        grand_waitingForActivationResponse = bool;
    }
    this.get_waitingForActivationResponse = function()
    {
        return grand_waitingForActivationResponse;
    }
    this.is_waitingForActivationResponse = function()
    {
        return grand_waitingForActivationResponse;
    }
    this.get_area = function()
    {
        return area;
    }
    this.activateSeat = function(id)
    {
        area.activateSeatFromJs(id);
    }
    this.blackoutSeat = function(id)
    {
        area.blackoutSeat(id, false);
    }
    this.blackoutSeatRespectingActivationRequest = function(id)
    {
        area.blackoutSeat(id, true);
    }
    this.normalizeSeat = function(id)
    {
        area.normalizeSeatFromJs(id);
    }
    this.dumpElements = function(dump)
    {
        area.dumpElements(dump);
    }
    this.resetStageArea = function()
    {
        reset_area();
    }
    function reset_area()
    {
        area = new HallArea();
        area.initialize();
    }
}
function HallArea()
{
    var SEAT_SIZE = 30;
    var OFFSET_SIZE = 50;
    var maxClickCount = 8;
    var clickCount = 0;
    var element_count_x = 0;
    var element_count_y = 0;
    var elements = new Object();
    this.initialize = function()
    {
        var a = jQuery("#seat_selector_holder");
        a.empty();
    }
    function createSeat(id, xpos, ypos, seatText, tickColor, state, position)
    {
        var seat = new Seat();
        seat.initialize({"seat_id": id,"div_id": "seat_" + id,"x": xpos * SEAT_SIZE * 0.5 + OFFSET_SIZE,"y": ypos * SEAT_SIZE * 0.5 + OFFSET_SIZE,"width": SEAT_SIZE,"height": SEAT_SIZE,"seatText": seatText,"tickColor": tickColor,"position": position,"state": state});
        elements["seat_" + id] = seat;
    }
    function createRowMarker(id, xpos, ypos, markerText, position)
    {
        var row_marker = new RowMarker();
        row_marker.initialize({"marker_id": id,"div_id": "marker_" + id,"x": xpos * SEAT_SIZE * 0.5 + OFFSET_SIZE,"y": ypos * SEAT_SIZE * 0.5 + OFFSET_SIZE,"width": SEAT_SIZE,"height": SEAT_SIZE,"position": position,"markerText": markerText});
    }
    function createComment(id, xpos, ypos, commentText, position)
    {
        var comment = new Comment();
        comment.initialize({"coment_id": id,"div_id": "comment_" + id,"x": xpos * SEAT_SIZE * 0.5 + OFFSET_SIZE,"y": ypos * SEAT_SIZE * 0.5 + OFFSET_SIZE,"width": SEAT_SIZE,"height": SEAT_SIZE,"position": position,"commentText": commentText});
    }
    function createPost(id, xpos, ypos, position)
    {
        var post = new Post();
        post.initialize({"post_id": id,"div_id": "post_" + id,"x": xpos * SEAT_SIZE * 0.5 + OFFSET_SIZE,"y": ypos * SEAT_SIZE * 0.5 + OFFSET_SIZE,"width": SEAT_SIZE,"position": position,"height": SEAT_SIZE});
    }
    function createUnusableArea(id, xpos, ypos, position)
    {
        var ua = new UnusableArea();
        ua.initialize({"ua_id": id,"div_id": "ua_" + id,"x": xpos * SEAT_SIZE * 0.5 + OFFSET_SIZE,"y": ypos * SEAT_SIZE * 0.5 + OFFSET_SIZE,"width": SEAT_SIZE,"position": position,"height": SEAT_SIZE});
    }
    this.dumpElements = function(dump)
    {
        position_type = "absolute";
        for (var i = 0; i < dump.length; i++)
        {
            var element = dump[i];
            if (element["type"] == "SeatMarked") {
                createSeat(element["id"], element["x"], element["y"], element["text"], element["tickcolor"], element["state"], position_type);
            }
            else if (element["type"] == "Post") {
                createPost(element["id"], element["x"], element["y"], position_type);
            }
            else if (element["type"] == "RowMarker") {
                createRowMarker(element["id"], element["x"], element["y"], element["text"], position_type);
            }
            else if (element["type"] == "Comment") {
                createComment(element["id"], element["x"], element["y"], element["text"], position_type);
            }
            else if (element["type"] == "UnusableArea") {
                createUnusableArea(element["id"], element["x"], element["y"], position_type);
            }
            else
                alert(element["type"])
        }
        this.resizeArea(dump);
    }
    this.resizeArea = function(dump) {
        var max_x = 0;
        var max_y = 0;
        for (var i = 0; i < dump.length; i++)
        {
            var e = dump[i];
            max_x = Math.max(max_x, e["x"]);
            max_y = Math.max(max_y, e["y"]);
        }
        var a = jQuery("#seat_selector_holder");
        jQuery('#kohavalik').css("width", (max_x * SEAT_SIZE * 0.5) + SEAT_SIZE + (OFFSET_SIZE * 2))
        a.css("height", (max_y * SEAT_SIZE * 0.5) + SEAT_SIZE + (OFFSET_SIZE * 2));
        a.css("width", (max_x * SEAT_SIZE * 0.5) + SEAT_SIZE + (OFFSET_SIZE * 2));
        var ww = jQuery(window).width();
        var cw = jQuery('#seat_selector_holder').width();
        var left_offset = (ww - cw < 0) ? 0 : ww / 2 - jQuery('#kohavalik').width() / 2;
        jQuery('#kohavalik').show().offset({top: 10,left: left_offset})
        var initial_scale = ww / cw;
        if (initial_scale < 1) {
            $("#seat_selector_holder").css('-webkit-transform', 'scale(' + initial_scale + ', ' + initial_scale + ')')
        }
    }
    this.activateSeatFromJs = function(id)
    {
        recordClick(1);
        elements["seat_" + id].makeActive();
        ss.set_waitingForActivationResponse(false);
    }
    this.blackoutSeat = function(id, respect_activation_request)
    {
        elements["seat_" + id].makeDeactive(respect_activation_request);
        ss.set_waitingForActivationResponse(false);
    }
    this.normalizeSeatFromJs = function(id)
    {
        recordClick(-1);
        elements["seat_" + id].makeNormal();
        ss.set_waitingForActivationResponse(false);
    }
    function getSeat(id)
    {
        return jQuery("#seat_" + id);
    }
    this.canClick = function()
    {
        return (maxClickCount > clickCount);
    }
    function recordClick(number)
    {
        clickCount += number;
    }
}
function Comment()
{
    var id;
    this.initialize = function(o)
    {
        id = o.comment_id;
        var div_id = o.div_id;
        var commentText = "";
        if (o.commentText != null) {
            commentText = o.commentText
        }
        jQuery("#seat_selector_holder").append("<div id='" + div_id + "' class=\"hall-element comment\">" + commentText + "</div>")
        var comment = jQuery("#" + div_id)
        comment.css({"left": o.x,"top": o.y})
    }
}
function RowMarker()
{
    var id;
    this.initialize = function(o)
    {
        id = o.marker_id;
        var div_id = o.div_id;
        var markerText = "";
        if (o.markerText != null) {
            markerText = o.markerText
        }
        jQuery("#seat_selector_holder").append("<div id='" + div_id + "' class=\"hall-element row-marker\">" + markerText + "</div>")
        var rm = jQuery("#" + div_id)
        rm.css("position", o.position)
        rm.css("width", o.width)
        rm.css("height", o.height)
        rm.css({"left": o.x,"top": o.y})
    }
}
function Post()
{
    var id;
    this.initialize = function(o)
    {
        id = o.post_id;
        var div_id = o.div_id;
        jQuery("#seat_selector_holder").append("<div id='" + div_id + "' class=\"hall-element post\"></div>")
        var post = jQuery("#" + div_id)
        post.css("position", o.position)
        post.css({"left": o.x,"top": o.y})
    }
}
function UnusableArea()
{
    var id;
    this.initialize = function(o)
    {
        id = o.post_id;
        var div_id = o.div_id;
        jQuery("#seat_selector_holder").append("<div id='" + div_id + "' class=\"hall-element unused-area\" ></div>")
        var post = jQuery("#" + div_id)
        post.css("position", o.position)
        post.css("width", o.width)
        post.css("height", o.height)
        post.css({"left": o.x,"top": o.y})
    }
}
function Seat()
{
    var id;
    var div_id = null;
    var active = false;
    var disabled = false;
    var tickColor = null;
    var cachedDomElement = null;
    var requestedForBeingActive = false;
    var CLICK_TIMEOUT_DELAY = 500;
    this.getDom = function() {
        if (cachedDomElement == null)
            cachedDomElement = jQuery("#" + div_id);
        return cachedDomElement;
    }
    this.initialize = function(o)
    {
        div_id = o.div_id;
        id = o.seat_id;
        var seatText = "";
        if (o.seatText != null) {
            seatText = o.seatText
        }
        tickHtml = '<div class="tick ' + o.tickColor + ' "></div>'
        jQuery("#seat_selector_holder").append("<div id='" + div_id + "' class=\"hall-element seat " + o.tickColor + "\"><div class=\"number\">" + seatText + tickHtml + "</div></div>")
        var seat = this.getDom();
        seat.css("position", o.position)
        seat.css({"left": o.x,"top": o.y})
        if (o.state == "notavailable")
            this.makeDeactive();
        else if (o.state == "active")
            this.makeActive();
        else if (o.state == "available")
            this.makeNormal();
        seat.click(on_seat_clicked_delayed);
    }
    var click_timer = false
    var obj_timout;
    function on_seat_clicked_delayed()
    {
        if (click_timer == false)
        {
            click_timer = true
            on_seat_clicked();
            clearTimeout(obj_timout)
            obj_timout = window.setTimeout(function() {
                click_timer = false;
            }, CLICK_TIMEOUT_DELAY);
        }
        else
        {
            clearTimeout(obj_timout)
            obj_timout = window.setTimeout(function() {
                click_timer = false;
            }, CLICK_TIMEOUT_DELAY);
        }
    }
    function on_seat_clicked()
    {
        if (iAmClickable())
        {
            ss.set_waitingForActivationResponse(true);
            if (!active)
            {
                requestedForBeingActive = true;
                seatActivated(id);
            }
            else
            {
                requestedForBeingActive = false;
                seatDeActivated(id);
            }
        }
    }
    this.removeClasses = function() {
        this.getDom().removeClass('available');
        this.getDom().removeClass('taken');
        this.getDom().removeClass('active');
    }
    this.makeActive = function()
    {
        active = true;
        this.removeClasses();
        this.getDom().addClass('active');
    }
    this.makeNormal = function()
    {
        active = false;
        requestedForBeingActive = false;
        disabled = false;
        this.removeClasses();
        this.getDom().addClass('available');
    }
    this.makeDeactive = function(respect_activation_request)
    {
        if (!respect_activation_request || !requestedForBeingActive)
        {
            disabled = true;
            this.removeClasses();
            this.getDom().addClass('taken');
        }
    }
    function iAmClickable()
    {
        return (!disabled) && (ss.get_area().canClick() || active) && !ss.is_waitingForActivationResponse();
    }
}
if (!jQuery)
    throw new Error("Bootstrap requires jQuery");
+function(a) {
    "use strict";
    function b() {
        var a = document.createElement("bootstrap"), b = {WebkitTransition: "webkitTransitionEnd",MozTransition: "transitionend",OTransition: "oTransitionEnd otransitionend",transition: "transitionend"};
        for (var c in b)
            if (void 0 !== a.style[c])
                return {end: b[c]}
    }
    a.fn.emulateTransitionEnd = function(b) {
        var c = !1, d = this;
        a(this).one(a.support.transition.end, function() {
            c = !0
        });
        var e = function() {
            c || a(d).trigger(a.support.transition.end)
        };
        return setTimeout(e, b), this
    }, a(function() {
        a.support.transition = b()
    })
}(window.jQuery), +function(a) {
    "use strict";
    var b = '[data-dismiss="alert"]', c = function(c) {
        a(c).on("click", b, this.close)
    };
    c.prototype.close = function(b) {
        function c() {
            f.trigger("closed.bs.alert").remove()
        }
        var d = a(this), e = d.attr("data-target");
        e || (e = d.attr("href"), e = e && e.replace(/.*(?=#[^\s]*$)/, ""));
        var f = a(e);
        b && b.preventDefault(), f.length || (f = d.hasClass("alert") ? d : d.parent()), f.trigger(b = a.Event("close.bs.alert")), b.isDefaultPrevented() || (f.removeClass("in"), a.support.transition && f.hasClass("fade") ? f.one(a.support.transition.end, c).emulateTransitionEnd(150) : c())
    };
    var d = a.fn.alert;
    a.fn.alert = function(b) {
        return this.each(function() {
            var d = a(this), e = d.data("bs.alert");
            e || d.data("bs.alert", e = new c(this)), "string" == typeof b && e[b].call(d)
        })
    }, a.fn.alert.Constructor = c, a.fn.alert.noConflict = function() {
        return a.fn.alert = d, this
    }, a(document).on("click.bs.alert.data-api", b, c.prototype.close)
}(window.jQuery), +function(a) {
    "use strict";
    var b = function(c, d) {
        this.$element = a(c), this.options = a.extend({}, b.DEFAULTS, d)
    };
    b.DEFAULTS = {loadingText: "loading..."}, b.prototype.setState = function(a) {
        var b = "disabled", c = this.$element, d = c.is("input") ? "val" : "html", e = c.data();
        a += "Text", e.resetText || c.data("resetText", c[d]()), c[d](e[a] || this.options[a]), setTimeout(function() {
            "loadingText" == a ? c.addClass(b).attr(b, b) : c.removeClass(b).removeAttr(b)
        }, 0)
    }, b.prototype.toggle = function() {
        var a = this.$element.closest('[data-toggle="buttons"]');
        if (a.length) {
            var b = this.$element.find("input").prop("checked", !this.$element.hasClass("active")).trigger("change");
            "radio" === b.prop("type") && a.find(".active").removeClass("active")
        }
        this.$element.toggleClass("active")
    };
    var c = a.fn.button;
    a.fn.button = function(c) {
        return this.each(function() {
            var d = a(this), e = d.data("bs.button"), f = "object" == typeof c && c;
            e || d.data("bs.button", e = new b(this, f)), "toggle" == c ? e.toggle() : c && e.setState(c)
        })
    }, a.fn.button.Constructor = b, a.fn.button.noConflict = function() {
        return a.fn.button = c, this
    }, a(document).on("click.bs.button.data-api", "[data-toggle^=button]", function(b) {
        var c = a(b.target);
        c.hasClass("btn") || (c = c.closest(".btn")), c.button("toggle"), b.preventDefault()
    })
}(window.jQuery), +function(a) {
    "use strict";
    var b = function(b, c) {
        this.$element = a(b), this.$indicators = this.$element.find(".carousel-indicators"), this.options = c, this.paused = this.sliding = this.interval = this.$active = this.$items = null, "hover" == this.options.pause && this.$element.on("mouseenter", a.proxy(this.pause, this)).on("mouseleave", a.proxy(this.cycle, this))
    };
    b.DEFAULTS = {interval: 5e3,pause: "hover",wrap: !0}, b.prototype.cycle = function(b) {
        return b || (this.paused = !1), this.interval && clearInterval(this.interval), this.options.interval && !this.paused && (this.interval = setInterval(a.proxy(this.next, this), this.options.interval)), this
    }, b.prototype.getActiveIndex = function() {
        return this.$active = this.$element.find(".item.active"), this.$items = this.$active.parent().children(), this.$items.index(this.$active)
    }, b.prototype.to = function(b) {
        var c = this, d = this.getActiveIndex();
        return b > this.$items.length - 1 || 0 > b ? void 0 : this.sliding ? this.$element.one("slid", function() {
            c.to(b)
        }) : d == b ? this.pause().cycle() : this.slide(b > d ? "next" : "prev", a(this.$items[b]))
    }, b.prototype.pause = function(b) {
        return b || (this.paused = !0), this.$element.find(".next, .prev").length && a.support.transition.end && (this.$element.trigger(a.support.transition.end), this.cycle(!0)), this.interval = clearInterval(this.interval), this
    }, b.prototype.next = function() {
        return this.sliding ? void 0 : this.slide("next")
    }, b.prototype.prev = function() {
        return this.sliding ? void 0 : this.slide("prev")
    }, b.prototype.slide = function(b, c) {
        var d = this.$element.find(".item.active"), e = c || d[b](), f = this.interval, g = "next" == b ? "left" : "right", h = "next" == b ? "first" : "last", i = this;
        if (!e.length) {
            if (!this.options.wrap)
                return;
            e = this.$element.find(".item")[h]()
        }
        this.sliding = !0, f && this.pause();
        var j = a.Event("slide.bs.carousel", {relatedTarget: e[0],direction: g});
        if (!e.hasClass("active")) {
            if (this.$indicators.length && (this.$indicators.find(".active").removeClass("active"), this.$element.one("slid", function() {
                var b = a(i.$indicators.children()[i.getActiveIndex()]);
                b && b.addClass("active")
            })), a.support.transition && this.$element.hasClass("slide")) {
                if (this.$element.trigger(j), j.isDefaultPrevented())
                    return;
                e.addClass(b), e[0].offsetWidth, d.addClass(g), e.addClass(g), d.one(a.support.transition.end, function() {
                    e.removeClass([b, g].join(" ")).addClass("active"), d.removeClass(["active", g].join(" ")), i.sliding = !1, setTimeout(function() {
                        i.$element.trigger("slid")
                    }, 0)
                }).emulateTransitionEnd(600)
            } else {
                if (this.$element.trigger(j), j.isDefaultPrevented())
                    return;
                d.removeClass("active"), e.addClass("active"), this.sliding = !1, this.$element.trigger("slid")
            }
            return f && this.cycle(), this
        }
    };
    var c = a.fn.carousel;
    a.fn.carousel = function(c) {
        return this.each(function() {
            var d = a(this), e = d.data("bs.carousel"), f = a.extend({}, b.DEFAULTS, d.data(), "object" == typeof c && c), g = "string" == typeof c ? c : f.slide;
            e || d.data("bs.carousel", e = new b(this, f)), "number" == typeof c ? e.to(c) : g ? e[g]() : f.interval && e.pause().cycle()
        })
    }, a.fn.carousel.Constructor = b, a.fn.carousel.noConflict = function() {
        return a.fn.carousel = c, this
    }, a(document).on("click.bs.carousel.data-api", "[data-slide], [data-slide-to]", function(b) {
        var c, d = a(this), e = a(d.attr("data-target") || (c = d.attr("href")) && c.replace(/.*(?=#[^\s]+$)/, "")), f = a.extend({}, e.data(), d.data()), g = d.attr("data-slide-to");
        g && (f.interval = !1), e.carousel(f), (g = d.attr("data-slide-to")) && e.data("bs.carousel").to(g), b.preventDefault()
    }), a(window).on("load", function() {
        a('[data-ride="carousel"]').each(function() {
            var b = a(this);
            b.carousel(b.data())
        })
    })
}(window.jQuery), +function(a) {
    "use strict";
    var b = function(c, d) {
        this.$element = a(c), this.options = a.extend({}, b.DEFAULTS, d), this.transitioning = null, this.options.parent && (this.$parent = a(this.options.parent)), this.options.toggle && this.toggle()
    };
    b.DEFAULTS = {toggle: !0}, b.prototype.dimension = function() {
        var a = this.$element.hasClass("width");
        return a ? "width" : "height"
    }, b.prototype.show = function() {
        if (!this.transitioning && !this.$element.hasClass("in")) {
            var b = a.Event("show.bs.collapse");
            if (this.$element.trigger(b), !b.isDefaultPrevented()) {
                var c = this.$parent && this.$parent.find("> .panel > .in");
                if (c && c.length) {
                    var d = c.data("bs.collapse");
                    if (d && d.transitioning)
                        return;
                    c.collapse("hide"), d || c.data("bs.collapse", null)
                }
                var e = this.dimension();
                this.$element.removeClass("collapse").addClass("collapsing")[e](0), this.transitioning = 1;
                var f = function() {
                    this.$element.removeClass("collapsing").addClass("in")[e]("auto"), this.transitioning = 0, this.$element.trigger("shown.bs.collapse")
                };
                if (!a.support.transition)
                    return f.call(this);
                var g = a.camelCase(["scroll", e].join("-"));
                this.$element.one(a.support.transition.end, a.proxy(f, this)).emulateTransitionEnd(350)[e](this.$element[0][g])
            }
        }
    }, b.prototype.hide = function() {
        if (!this.transitioning && this.$element.hasClass("in")) {
            var b = a.Event("hide.bs.collapse");
            if (this.$element.trigger(b), !b.isDefaultPrevented()) {
                var c = this.dimension();
                this.$element[c](this.$element[c]())[0].offsetHeight, this.$element.addClass("collapsing").removeClass("collapse").removeClass("in"), this.transitioning = 1;
                var d = function() {
                    this.transitioning = 0, this.$element.trigger("hidden.bs.collapse").removeClass("collapsing").addClass("collapse")
                };
                return a.support.transition ? (this.$element[c](0).one(a.support.transition.end, a.proxy(d, this)).emulateTransitionEnd(350), void 0) : d.call(this)
            }
        }
    }, b.prototype.toggle = function() {
        this[this.$element.hasClass("in") ? "hide" : "show"]()
    };
    var c = a.fn.collapse;
    a.fn.collapse = function(c) {
        return this.each(function() {
            var d = a(this), e = d.data("bs.collapse"), f = a.extend({}, b.DEFAULTS, d.data(), "object" == typeof c && c);
            e || d.data("bs.collapse", e = new b(this, f)), "string" == typeof c && e[c]()
        })
    }, a.fn.collapse.Constructor = b, a.fn.collapse.noConflict = function() {
        return a.fn.collapse = c, this
    }, a(document).on("click.bs.collapse.data-api", "[data-toggle=collapse]", function(b) {
        var c, d = a(this), e = d.attr("data-target") || b.preventDefault() || (c = d.attr("href")) && c.replace(/.*(?=#[^\s]+$)/, ""), f = a(e), g = f.data("bs.collapse"), h = g ? "toggle" : d.data(), i = d.attr("data-parent"), j = i && a(i);
        g && g.transitioning || (j && j.find('[data-toggle=collapse][data-parent="' + i + '"]').not(d).addClass("collapsed"), d[f.hasClass("in") ? "addClass" : "removeClass"]("collapsed")), f.collapse(h)
    })
}(window.jQuery), +function(a) {
    "use strict";
    function b() {
        a(d).remove(), a(e).each(function(b) {
            var d = c(a(this));
            d.hasClass("open") && (d.trigger(b = a.Event("hide.bs.dropdown")), b.isDefaultPrevented() || d.removeClass("open").trigger("hidden.bs.dropdown"))
        })
    }
    function c(b) {
        var c = b.attr("data-target");
        c || (c = b.attr("href"), c = c && /#/.test(c) && c.replace(/.*(?=#[^\s]*$)/, ""));
        var d = c && a(c);
        return d && d.length ? d : b.parent()
    }
    var d = ".dropdown-backdrop", e = "[data-toggle=dropdown]", f = function(b) {
        a(b).on("click.bs.dropdown", this.toggle)
    };
    f.prototype.toggle = function(d) {
        var e = a(this);
        if (!e.is(".disabled, :disabled")) {
            var f = c(e), g = f.hasClass("open");
            if (b(), !g) {
                if ("ontouchstart" in document.documentElement && !f.closest(".navbar-nav").length && a('<div class="dropdown-backdrop"/>').insertAfter(a(this)).on("click", b), f.trigger(d = a.Event("show.bs.dropdown")), d.isDefaultPrevented())
                    return;
                f.toggleClass("open").trigger("shown.bs.dropdown"), e.focus()
            }
            return !1
        }
    }, f.prototype.keydown = function(b) {
        if (/(38|40|27)/.test(b.keyCode)) {
            var d = a(this);
            if (b.preventDefault(), b.stopPropagation(), !d.is(".disabled, :disabled")) {
                var f = c(d), g = f.hasClass("open");
                if (!g || g && 27 == b.keyCode)
                    return 27 == b.which && f.find(e).focus(), d.click();
                var h = a("[role=menu] li:not(.divider):visible a", f);
                if (h.length) {
                    var i = h.index(h.filter(":focus"));
                    38 == b.keyCode && i > 0 && i--, 40 == b.keyCode && i < h.length - 1 && i++, ~i || (i = 0), h.eq(i).focus()
                }
            }
        }
    };
    var g = a.fn.dropdown;
    a.fn.dropdown = function(b) {
        return this.each(function() {
            var c = a(this), d = c.data("dropdown");
            d || c.data("dropdown", d = new f(this)), "string" == typeof b && d[b].call(c)
        })
    }, a.fn.dropdown.Constructor = f, a.fn.dropdown.noConflict = function() {
        return a.fn.dropdown = g, this
    }, a(document).on("click.bs.dropdown.data-api", b).on("click.bs.dropdown.data-api", ".dropdown form", function(a) {
        a.stopPropagation()
    }).on("click.bs.dropdown.data-api", e, f.prototype.toggle).on("keydown.bs.dropdown.data-api", e + ", [role=menu]", f.prototype.keydown)
}(window.jQuery), +function(a) {
    "use strict";
    var b = function(b, c) {
        this.options = c, this.$element = a(b), this.$backdrop = this.isShown = null, this.options.remote && this.$element.load(this.options.remote)
    };
    b.DEFAULTS = {backdrop: !0,keyboard: !0,show: !0}, b.prototype.toggle = function(a) {
        return this[this.isShown ? "hide" : "show"](a)
    }, b.prototype.show = function(b) {
        var c = this, d = a.Event("show.bs.modal", {relatedTarget: b});
        this.$element.trigger(d), this.isShown || d.isDefaultPrevented() || (this.isShown = !0, this.escape(), this.$element.on("click.dismiss.modal", '[data-dismiss="modal"]', a.proxy(this.hide, this)), this.backdrop(function() {
            var d = a.support.transition && c.$element.hasClass("fade");
            c.$element.parent().length || c.$element.appendTo(document.body), c.$element.show(), d && c.$element[0].offsetWidth, c.$element.addClass("in").attr("aria-hidden", !1), c.enforceFocus();
            var e = a.Event("shown.bs.modal", {relatedTarget: b});
            d ? c.$element.find(".modal-dialog").one(a.support.transition.end, function() {
                c.$element.focus().trigger(e)
            }).emulateTransitionEnd(300) : c.$element.focus().trigger(e)
        }))
    }, b.prototype.hide = function(b) {
        b && b.preventDefault(), b = a.Event("hide.bs.modal"), this.$element.trigger(b), this.isShown && !b.isDefaultPrevented() && (this.isShown = !1, this.escape(), a(document).off("focusin.bs.modal"), this.$element.removeClass("in").attr("aria-hidden", !0).off("click.dismiss.modal"), a.support.transition && this.$element.hasClass("fade") ? this.$element.one(a.support.transition.end, a.proxy(this.hideModal, this)).emulateTransitionEnd(300) : this.hideModal())
    }, b.prototype.enforceFocus = function() {
        a(document).off("focusin.bs.modal").on("focusin.bs.modal", a.proxy(function(a) {
            this.$element[0] === a.target || this.$element.has(a.target).length || this.$element.focus()
        }, this))
    }, b.prototype.escape = function() {
        this.isShown && this.options.keyboard ? this.$element.on("keyup.dismiss.bs.modal", a.proxy(function(a) {
            27 == a.which && this.hide()
        }, this)) : this.isShown || this.$element.off("keyup.dismiss.bs.modal")
    }, b.prototype.hideModal = function() {
        var a = this;
        this.$element.hide(), this.backdrop(function() {
            a.removeBackdrop(), a.$element.trigger("hidden.bs.modal")
        })
    }, b.prototype.removeBackdrop = function() {
        this.$backdrop && this.$backdrop.remove(), this.$backdrop = null
    }, b.prototype.backdrop = function(b) {
        var c = this.$element.hasClass("fade") ? "fade" : "";
        if (this.isShown && this.options.backdrop) {
            var d = a.support.transition && c;
            if (this.$backdrop = a('<div class="modal-backdrop ' + c + '" />').appendTo(document.body), this.$element.on("click.dismiss.modal", a.proxy(function(a) {
                a.target === a.currentTarget && ("static" == this.options.backdrop ? this.$element[0].focus.call(this.$element[0]) : this.hide.call(this))
            }, this)), d && this.$backdrop[0].offsetWidth, this.$backdrop.addClass("in"), !b)
                return;
            d ? this.$backdrop.one(a.support.transition.end, b).emulateTransitionEnd(150) : b()
        } else
            !this.isShown && this.$backdrop ? (this.$backdrop.removeClass("in"), a.support.transition && this.$element.hasClass("fade") ? this.$backdrop.one(a.support.transition.end, b).emulateTransitionEnd(150) : b()) : b && b()
    };
    var c = a.fn.modal;
    a.fn.modal = function(c, d) {
        return this.each(function() {
            var e = a(this), f = e.data("bs.modal"), g = a.extend({}, b.DEFAULTS, e.data(), "object" == typeof c && c);
            f || e.data("bs.modal", f = new b(this, g)), "string" == typeof c ? f[c](d) : g.show && f.show(d)
        })
    }, a.fn.modal.Constructor = b, a.fn.modal.noConflict = function() {
        return a.fn.modal = c, this
    }, a(document).on("click.bs.modal.data-api", '[data-toggle="modal"]', function(b) {
        var c = a(this), d = c.attr("href"), e = a(c.attr("data-target") || d && d.replace(/.*(?=#[^\s]+$)/, "")), f = e.data("modal") ? "toggle" : a.extend({remote: !/#/.test(d) && d}, e.data(), c.data());
        b.preventDefault(), e.modal(f, this).one("hide", function() {
            c.is(":visible") && c.focus()
        })
    }), a(document).on("show.bs.modal", ".modal", function() {
        a(document.body).addClass("modal-open")
    }).on("hidden.bs.modal", ".modal", function() {
        a(document.body).removeClass("modal-open")
    })
}(window.jQuery), +function(a) {
    "use strict";
    var b = function(a, b) {
        this.type = this.options = this.enabled = this.timeout = this.hoverState = this.$element = null, this.init("tooltip", a, b)
    };
    b.DEFAULTS = {animation: !0,placement: "top",selector: !1,template: '<div class="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>',trigger: "hover focus",title: "",delay: 0,html: !1,container: !1}, b.prototype.init = function(b, c, d) {
        this.enabled = !0, this.type = b, this.$element = a(c), this.options = this.getOptions(d);
        for (var e = this.options.trigger.split(" "), f = e.length; f--; ) {
            var g = e[f];
            if ("click" == g)
                this.$element.on("click." + this.type, this.options.selector, a.proxy(this.toggle, this));
            else if ("manual" != g) {
                var h = "hover" == g ? "mouseenter" : "focus", i = "hover" == g ? "mouseleave" : "blur";
                this.$element.on(h + "." + this.type, this.options.selector, a.proxy(this.enter, this)), this.$element.on(i + "." + this.type, this.options.selector, a.proxy(this.leave, this))
            }
        }
        this.options.selector ? this._options = a.extend({}, this.options, {trigger: "manual",selector: ""}) : this.fixTitle()
    }, b.prototype.getDefaults = function() {
        return b.DEFAULTS
    }, b.prototype.getOptions = function(b) {
        return b = a.extend({}, this.getDefaults(), this.$element.data(), b), b.delay && "number" == typeof b.delay && (b.delay = {show: b.delay,hide: b.delay}), b
    }, b.prototype.getDelegateOptions = function() {
        var b = {}, c = this.getDefaults();
        return this._options && a.each(this._options, function(a, d) {
            c[a] != d && (b[a] = d)
        }), b
    }, b.prototype.enter = function(b) {
        var c = b instanceof this.constructor ? b : a(b.currentTarget)[this.type](this.getDelegateOptions()).data("bs." + this.type);
        return clearTimeout(c.timeout), c.hoverState = "in", c.options.delay && c.options.delay.show ? (c.timeout = setTimeout(function() {
            "in" == c.hoverState && c.show()
        }, c.options.delay.show), void 0) : c.show()
    }, b.prototype.leave = function(b) {
        var c = b instanceof this.constructor ? b : a(b.currentTarget)[this.type](this.getDelegateOptions()).data("bs." + this.type);
        return clearTimeout(c.timeout), c.hoverState = "out", c.options.delay && c.options.delay.hide ? (c.timeout = setTimeout(function() {
            "out" == c.hoverState && c.hide()
        }, c.options.delay.hide), void 0) : c.hide()
    }, b.prototype.show = function() {
        var b = a.Event("show.bs." + this.type);
        if (this.hasContent() && this.enabled) {
            if (this.$element.trigger(b), b.isDefaultPrevented())
                return;
            var c = this.tip();
            this.setContent(), this.options.animation && c.addClass("fade");
            var d = "function" == typeof this.options.placement ? this.options.placement.call(this, c[0], this.$element[0]) : this.options.placement, e = /\s?auto?\s?/i, f = e.test(d);
            f && (d = d.replace(e, "") || "top"), c.detach().css({top: 0,left: 0,display: "block"}).addClass(d), this.options.container ? c.appendTo(this.options.container) : c.insertAfter(this.$element);
            var g = this.getPosition(), h = c[0].offsetWidth, i = c[0].offsetHeight;
            if (f) {
                var j = this.$element.parent(), k = d, l = document.documentElement.scrollTop || document.body.scrollTop, m = "body" == this.options.container ? window.innerWidth : j.outerWidth(), n = "body" == this.options.container ? window.innerHeight : j.outerHeight(), o = "body" == this.options.container ? 0 : j.offset().left;
                d = "bottom" == d && g.top + g.height + i - l > n ? "top" : "top" == d && g.top - l - i < 0 ? "bottom" : "right" == d && g.right + h > m ? "left" : "left" == d && g.left - h < o ? "right" : d, c.removeClass(k).addClass(d)
            }
            var p = this.getCalculatedOffset(d, g, h, i);
            this.applyPlacement(p, d), this.$element.trigger("shown.bs." + this.type)
        }
    }, b.prototype.applyPlacement = function(a, b) {
        var c, d = this.tip(), e = d[0].offsetWidth, f = d[0].offsetHeight, g = parseInt(d.css("margin-top"), 10), h = parseInt(d.css("margin-left"), 10);
        isNaN(g) && (g = 0), isNaN(h) && (h = 0), a.top = a.top + g, a.left = a.left + h, d.offset(a).addClass("in");
        var i = d[0].offsetWidth, j = d[0].offsetHeight;
        if ("top" == b && j != f && (c = !0, a.top = a.top + f - j), /bottom|top/.test(b)) {
            var k = 0;
            a.left < 0 && (k = -2 * a.left, a.left = 0, d.offset(a), i = d[0].offsetWidth, j = d[0].offsetHeight), this.replaceArrow(k - e + i, i, "left")
        } else
            this.replaceArrow(j - f, j, "top");
        c && d.offset(a)
    }, b.prototype.replaceArrow = function(a, b, c) {
        this.arrow().css(c, a ? 50 * (1 - a / b) + "%" : "")
    }, b.prototype.setContent = function() {
        var a = this.tip(), b = this.getTitle();
        a.find(".tooltip-inner")[this.options.html ? "html" : "text"](b), a.removeClass("fade in top bottom left right")
    }, b.prototype.hide = function() {
        function b() {
            "in" != c.hoverState && d.detach()
        }
        var c = this, d = this.tip(), e = a.Event("hide.bs." + this.type);
        return this.$element.trigger(e), e.isDefaultPrevented() ? void 0 : (d.removeClass("in"), a.support.transition && this.$tip.hasClass("fade") ? d.one(a.support.transition.end, b).emulateTransitionEnd(150) : b(), this.$element.trigger("hidden.bs." + this.type), this)
    }, b.prototype.fixTitle = function() {
        var a = this.$element;
        (a.attr("title") || "string" != typeof a.attr("data-original-title")) && a.attr("data-original-title", a.attr("title") || "").attr("title", "")
    }, b.prototype.hasContent = function() {
        return this.getTitle()
    }, b.prototype.getPosition = function() {
        var b = this.$element[0];
        return a.extend({}, "function" == typeof b.getBoundingClientRect ? b.getBoundingClientRect() : {width: b.offsetWidth,height: b.offsetHeight}, this.$element.offset())
    }, b.prototype.getCalculatedOffset = function(a, b, c, d) {
        return "bottom" == a ? {top: b.top + b.height,left: b.left + b.width / 2 - c / 2} : "top" == a ? {top: b.top - d,left: b.left + b.width / 2 - c / 2} : "left" == a ? {top: b.top + b.height / 2 - d / 2,left: b.left - c} : {top: b.top + b.height / 2 - d / 2,left: b.left + b.width}
    }, b.prototype.getTitle = function() {
        var a, b = this.$element, c = this.options;
        return a = b.attr("data-original-title") || ("function" == typeof c.title ? c.title.call(b[0]) : c.title)
    }, b.prototype.tip = function() {
        return this.$tip = this.$tip || a(this.options.template)
    }, b.prototype.arrow = function() {
        return this.$arrow = this.$arrow || this.tip().find(".tooltip-arrow")
    }, b.prototype.validate = function() {
        this.$element[0].parentNode || (this.hide(), this.$element = null, this.options = null)
    }, b.prototype.enable = function() {
        this.enabled = !0
    }, b.prototype.disable = function() {
        this.enabled = !1
    }, b.prototype.toggleEnabled = function() {
        this.enabled = !this.enabled
    }, b.prototype.toggle = function(b) {
        var c = b ? a(b.currentTarget)[this.type](this.getDelegateOptions()).data("bs." + this.type) : this;
        c.tip().hasClass("in") ? c.leave(c) : c.enter(c)
    }, b.prototype.destroy = function() {
        this.hide().$element.off("." + this.type).removeData("bs." + this.type)
    };
    var c = a.fn.tooltip;
    a.fn.tooltip = function(c) {
        return this.each(function() {
            var d = a(this), e = d.data("bs.tooltip"), f = "object" == typeof c && c;
            e || d.data("bs.tooltip", e = new b(this, f)), "string" == typeof c && e[c]()
        })
    }, a.fn.tooltip.Constructor = b, a.fn.tooltip.noConflict = function() {
        return a.fn.tooltip = c, this
    }
}(window.jQuery), +function(a) {
    "use strict";
    var b = function(a, b) {
        this.init("popover", a, b)
    };
    if (!a.fn.tooltip)
        throw new Error("Popover requires tooltip.js");
    b.DEFAULTS = a.extend({}, a.fn.tooltip.Constructor.DEFAULTS, {placement: "right",trigger: "click",content: "",template: '<div class="popover"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>'}), b.prototype = a.extend({}, a.fn.tooltip.Constructor.prototype), b.prototype.constructor = b, b.prototype.getDefaults = function() {
        return b.DEFAULTS
    }, b.prototype.setContent = function() {
        var a = this.tip(), b = this.getTitle(), c = this.getContent();
        a.find(".popover-title")[this.options.html ? "html" : "text"](b), a.find(".popover-content")[this.options.html ? "html" : "text"](c), a.removeClass("fade top bottom left right in"), a.find(".popover-title").html() || a.find(".popover-title").hide()
    }, b.prototype.hasContent = function() {
        return this.getTitle() || this.getContent()
    }, b.prototype.getContent = function() {
        var a = this.$element, b = this.options;
        return a.attr("data-content") || ("function" == typeof b.content ? b.content.call(a[0]) : b.content)
    }, b.prototype.arrow = function() {
        return this.$arrow = this.$arrow || this.tip().find(".arrow")
    }, b.prototype.tip = function() {
        return this.$tip || (this.$tip = a(this.options.template)), this.$tip
    };
    var c = a.fn.popover;
    a.fn.popover = function(c) {
        return this.each(function() {
            var d = a(this), e = d.data("bs.popover"), f = "object" == typeof c && c;
            e || d.data("bs.popover", e = new b(this, f)), "string" == typeof c && e[c]()
        })
    }, a.fn.popover.Constructor = b, a.fn.popover.noConflict = function() {
        return a.fn.popover = c, this
    }
}(window.jQuery), +function(a) {
    "use strict";
    function b(c, d) {
        var e, f = a.proxy(this.process, this);
        this.$element = a(c).is("body") ? a(window) : a(c), this.$body = a("body"), this.$scrollElement = this.$element.on("scroll.bs.scroll-spy.data-api", f), this.options = a.extend({}, b.DEFAULTS, d), this.selector = (this.options.target || (e = a(c).attr("href")) && e.replace(/.*(?=#[^\s]+$)/, "") || "") + " .nav li > a", this.offsets = a([]), this.targets = a([]), this.activeTarget = null, this.refresh(), this.process()
    }
    b.DEFAULTS = {offset: 10}, b.prototype.refresh = function() {
        var b = this.$element[0] == window ? "offset" : "position";
        this.offsets = a([]), this.targets = a([]);
        var c = this;
        this.$body.find(this.selector).map(function() {
            var d = a(this), e = d.data("target") || d.attr("href"), f = /^#\w/.test(e) && a(e);
            return f && f.length && [[f[b]().top + (!a.isWindow(c.$scrollElement.get(0)) && c.$scrollElement.scrollTop()), e]] || null
        }).sort(function(a, b) {
            return a[0] - b[0]
        }).each(function() {
            c.offsets.push(this[0]), c.targets.push(this[1])
        })
    }, b.prototype.process = function() {
        var a, b = this.$scrollElement.scrollTop() + this.options.offset, c = this.$scrollElement[0].scrollHeight || this.$body[0].scrollHeight, d = c - this.$scrollElement.height(), e = this.offsets, f = this.targets, g = this.activeTarget;
        if (b >= d)
            return g != (a = f.last()[0]) && this.activate(a);
        for (a = e.length; a--; )
            g != f[a] && b >= e[a] && (!e[a + 1] || b <= e[a + 1]) && this.activate(f[a])
    }, b.prototype.activate = function(b) {
        this.activeTarget = b, a(this.selector).parents(".active").removeClass("active");
        var c = this.selector + '[data-target="' + b + '"],' + this.selector + '[href="' + b + '"]', d = a(c).parents("li").addClass("active");
        d.parent(".dropdown-menu").length && (d = d.closest("li.dropdown").addClass("active")), d.trigger("activate")
    };
    var c = a.fn.scrollspy;
    a.fn.scrollspy = function(c) {
        return this.each(function() {
            var d = a(this), e = d.data("bs.scrollspy"), f = "object" == typeof c && c;
            e || d.data("bs.scrollspy", e = new b(this, f)), "string" == typeof c && e[c]()
        })
    }, a.fn.scrollspy.Constructor = b, a.fn.scrollspy.noConflict = function() {
        return a.fn.scrollspy = c, this
    }, a(window).on("load", function() {
        a('[data-spy="scroll"]').each(function() {
            var b = a(this);
            b.scrollspy(b.data())
        })
    })
}(window.jQuery), +function(a) {
    "use strict";
    var b = function(b) {
        this.element = a(b)
    };
    b.prototype.show = function() {
        var b = this.element, c = b.closest("ul:not(.dropdown-menu)"), d = b.attr("data-target");
        if (d || (d = b.attr("href"), d = d && d.replace(/.*(?=#[^\s]*$)/, "")), !b.parent("li").hasClass("active")) {
            var e = c.find(".active:last a")[0], f = a.Event("show.bs.tab", {relatedTarget: e});
            if (b.trigger(f), !f.isDefaultPrevented()) {
                var g = a(d);
                this.activate(b.parent("li"), c), this.activate(g, g.parent(), function() {
                    b.trigger({type: "shown.bs.tab",relatedTarget: e})
                })
            }
        }
    }, b.prototype.activate = function(b, c, d) {
        function e() {
            f.removeClass("active").find("> .dropdown-menu > .active").removeClass("active"), b.addClass("active"), g ? (b[0].offsetWidth, b.addClass("in")) : b.removeClass("fade"), b.parent(".dropdown-menu") && b.closest("li.dropdown").addClass("active"), d && d()
        }
        var f = c.find("> .active"), g = d && a.support.transition && f.hasClass("fade");
        g ? f.one(a.support.transition.end, e).emulateTransitionEnd(150) : e(), f.removeClass("in")
    };
    var c = a.fn.tab;
    a.fn.tab = function(c) {
        return this.each(function() {
            var d = a(this), e = d.data("bs.tab");
            e || d.data("bs.tab", e = new b(this)), "string" == typeof c && e[c]()
        })
    }, a.fn.tab.Constructor = b, a.fn.tab.noConflict = function() {
        return a.fn.tab = c, this
    }, a(document).on("click.bs.tab.data-api", '[data-toggle="tab"], [data-toggle="pill"]', function(b) {
        b.preventDefault(), a(this).tab("show")
    })
}(window.jQuery), +function(a) {
    "use strict";
    var b = function(c, d) {
        this.options = a.extend({}, b.DEFAULTS, d), this.$window = a(window).on("scroll.bs.affix.data-api", a.proxy(this.checkPosition, this)).on("click.bs.affix.data-api", a.proxy(this.checkPositionWithEventLoop, this)), this.$element = a(c), this.affixed = this.unpin = null, this.checkPosition()
    };
    b.RESET = "affix affix-top affix-bottom", b.DEFAULTS = {offset: 0}, b.prototype.checkPositionWithEventLoop = function() {
        setTimeout(a.proxy(this.checkPosition, this), 1)
    }, b.prototype.checkPosition = function() {
        if (this.$element.is(":visible")) {
            var c = a(document).height(), d = this.$window.scrollTop(), e = this.$element.offset(), f = this.options.offset, g = f.top, h = f.bottom;
            "object" != typeof f && (h = g = f), "function" == typeof g && (g = f.top()), "function" == typeof h && (h = f.bottom());
            var i = null != this.unpin && d + this.unpin <= e.top ? !1 : null != h && e.top + this.$element.height() >= c - h ? "bottom" : null != g && g >= d ? "top" : !1;
            this.affixed !== i && (this.unpin && this.$element.css("top", ""), this.affixed = i, this.unpin = "bottom" == i ? e.top - d : null, this.$element.removeClass(b.RESET).addClass("affix" + (i ? "-" + i : "")), "bottom" == i && this.$element.offset({top: document.body.offsetHeight - h - this.$element.height()}))
        }
    };
    var c = a.fn.affix;
    a.fn.affix = function(c) {
        return this.each(function() {
            var d = a(this), e = d.data("bs.affix"), f = "object" == typeof c && c;
            e || d.data("bs.affix", e = new b(this, f)), "string" == typeof c && e[c]()
        })
    }, a.fn.affix.Constructor = b, a.fn.affix.noConflict = function() {
        return a.fn.affix = c, this
    }, a(window).on("load", function() {
        a('[data-spy="affix"]').each(function() {
            var b = a(this), c = b.data();
            c.offset = c.offset || {}, c.offsetBottom && (c.offset.bottom = c.offsetBottom), c.offsetTop && (c.offset.top = c.offsetTop), b.affix(c)
        })
    })
}(window.jQuery);
$(document).ready(function() {
    var mobile_width = 991;
    var desktop_width = 1200;
    var width;
    var is_mobile = false;
    var $window = $(window);
    var menu_state = '';
    function make_mobile() {
        hide_menus();
        var menu = $("#menu");
        var mobile_container = $("#mobile_container");
        menu_state = '';
        is_mobile = true;
        mobile_container.append($("#set_language"));
        mobile_container.append(menu);
        mobile_container.append($("#minu_piletimaailm"));
        mobile_container.append($("#telli_uudiskiri"));
        mobile_container.append($("#catalog_container"));
        mobile_container.append($("#marksonadega"));
        mobile_container.append($("#otsing_container"));
        $(".show-items").each(function(index, element) {
            $(element).next(".hide-items").hide();
        });
        $("#menu ul li").addClass("mobile-menu");
        $("#mobile_menu_button").show();
        $("#mobile-checkout-crumbs").append($("#progress-bar"));
    }
    var menu_divs = "#set_language, #menu, #otsing_container, #marksonadega, #minu_piletimaailm, #telli_uudiskiri, #catalog_container";
    function hide_menus() {
        $(menu_divs).hide();
    }
    function smooth_hide_menus() {
        $(menu_divs).slideUp();
    }
    function show_menus() {
        $("#set_language, #menu, #otsing_container, #marksonadega, #minu_piletimaailm, #telli_uudiskiri, #catalog_container").show();
    }
    function hide_language_menus() {
        $("#set_language").slideUp();
    }
    function show_language_menus() {
        $("#set_language").slideDown();
    }
    function hide_info_menus() {
        $("#menu").slideUp();
    }
    function show_info_menus() {
        $("#menu").slideDown();
    }
    function hide_my_menus() {
        $("#minu_piletimaailm, #telli_uudiskiri").slideUp();
    }
    function show_my_menus() {
        $("#minu_piletimaailm, #telli_uudiskiri").slideDown();
    }
    function hide_event_menus() {
        $("#otsing_container, #marksonadega, #catalog_container").slideUp();
    }
    function show_event_menus() {
        $("#otsing_container, #marksonadega, #catalog_container").slideDown();
    }
    function attach_mobile_menu_hooks() {
        $("#mobile_menu_button #btn_languages").click(function() {
            if (menu_state != 'languages_open') {
                smooth_hide_menus();
                show_language_menus();
                menu_state = 'languages_open';
            }
            else {
                menu_state = '';
                hide_language_menus();
            }
        });
        $("#mobile_menu_button #btn_info").click(function() {
            if (menu_state != 'info_open') {
                smooth_hide_menus();
                show_info_menus();
                menu_state = 'info_open';
            }
            else {
                menu_state = '';
                hide_info_menus();
            }
        });
        $("#mobile_menu_button #btn_love").click(function() {
            if (menu_state != 'info_my') {
                smooth_hide_menus();
                show_my_menus();
                menu_state = 'info_my';
            }
            else {
                menu_state = '';
                hide_my_menus();
            }
        });
        $("#mobile_menu_button #btn_menu").click(function() {
            if (menu_state != 'menu_open') {
                smooth_hide_menus();
                show_event_menus();
                menu_state = 'menu_open';
            }
            else {
                menu_state = '';
                hide_event_menus();
            }
        });
    }
    attach_mobile_menu_hooks();
    function make_desktop() {
        var menu = $("#menu");
        var menu_container = $("#menu_container");
        var otsi = $("#otsi");
        is_mobile = false;
        menu_container.append(menu);
        otsi.prepend($("#telli_uudiskiri"));
        otsi.prepend($("#minu_piletimaailm"));
        otsi.prepend($("#marksonadega"));
        otsi.prepend($("#otsing_container"));
        $(".show-items").each(function(index, element) {
            $(element).next(".hide-items").show();
        });
        $("#menu ul li").removeClass("mobile-menu");
        $("#set_language_row").prepend($("#set_language"));
        $("#organisers").append($("#catalog_container"));
        $("#mobile_menu_button").hide();
        show_menus();
        $("#banner-container").append($("#progress-bar"));
    }
    var last_mobile_width = 0;
    function checkWidth() {
        if ($("#taust")) {
            $("#taust").css("height", $(window).height());
        }
        var windowsize = $window.width();
        if (last_mobile_width == windowsize)
            return;
        if (windowsize <= mobile_width) {
            make_mobile();
            last_mobile_width = windowsize;
        } else {
            last_mobile_width = 0;
            make_desktop();
        }
    }
    $("div.news_article").click(function() {
        window.location = $(this).data("url");
    });
    checkWidth();
    $(window).resize(checkWidth)
    function toggle_hidden_items(e) {
        if (is_mobile) {
            $(e).next(".hide-items").toggle();
        }
    }
    $(".show-items").parent().click(function() {
        toggle_hidden_items($(this).find(".show-items"));
    });
    attach_search_event_hooks();
    attach_minu_piletimaailm_event_hooks();
    $(".show-more-keywords").click(function(e) {
        $('.naita-peida-marksonu').toggle();
        $('#marksonad').toggle();
        e.stopPropagation();
    });
    $("#screens_list li").click(function() {
        showSeatChooser($(this).data("screen"));
    });
    $("#performance_full_name").autocomplete({"source": function(o, response) {
        $.ajax({type: "POST",url: "/performances/auto_complete_for_performance_full_name_et",dataType: "json",data: {"performance_full_name_et": o.term,"json": 1},success: function(data) {
            response($.map(data, function(obj) {
                return {label: obj,value: obj}
            }));
        }})
    }});
    $("#venue_name").autocomplete({"source": function(o, response) {
        $.ajax({type: "POST",url: "/venues/auto_complete_for_venue_name",dataType: "json",data: {"venue_name": o.term,"json": 1},success: function(data) {
            response($.map(data, function(obj) {
                return {label: obj,value: obj}
            }));
        }})
    }});
    $("#osta-pilet-katkesta").click(function() {
        hideEditor();
        hide_time_out_message();
    });
    $("#osta-pilet-kinnita-valik").click(function() {
        $('#osta-pilet-vorm').submit();
    });
    $("li.clickable").click(function() {
        window.location = $(this).children().first().attr("href");
    });
    $("#from_show").datepicker();
    $("#to_show").datepicker();
    $("#osta-kohe-nupp").click(function() {
        $("#osta-kohe").slideDown();
        $("#clients-unregistered").addClass('col-md-offset-6');
        $("#clients-register").slideUp();
        $("#clients-log-in").slideUp();
        $("#clients-osta-kohe-intro").slideUp();
    });
    $("#clients-cancel-ostakohe").click(function() {
        $("#clients-unregistered").removeClass('col-md-offset-6');
        $("#osta-kohe").slideUp();
        $("#clients-log-in").slideDown();
        $("#clients-osta-kohe-intro").slideDown();
        $("#clients-register").slideDown();
    });
    $("#osta-kohe-vorm").submit(function(e) {
        $("#client_first_name").removeClass('error');
        $("#client_last_name").removeClass('error');
        $("#client_email").removeClass('error');
        $("#client_phone").removeClass('error');
        $("#errorExplanation ul").empty();
        $("#errorExplanation").hide();
        jQuery.ajax({type: "POST",url: $(this).attr("action"),data: $(this).serialize(),success: function(response) {
            if (response.success)
                window.location.href = response.redirect;
            else {
                var errors = false;
                if (response.errors.first_name.length > 0) {
                    errors = true;
                    $("#client_first_name").addClass('error');
                    $("#errorExplanation ul").prepend("<li>" + response.errors.first_name + "</li>")
                }
                if (response.errors.last_name.length > 0) {
                    errors = true
                    $("#client_last_name").addClass('error');
                    $("#errorExplanation ul").prepend("<li>" + response.errors.last_name + "</li>")
                }
                if (response.errors.email.length > 0) {
                    errors = true;
                    $("#client_email").addClass('error');
                    $("#errorExplanation ul").prepend("<li>" + response.errors.email + "</li>")
                }
                if (response.errors.phone.length > 0) {
                    errors = true;
                    $("#client_phone").addClass('error');
                    $("#errorExplanation ul").prepend("<li>" + response.errors.phone + "</li>")
                }
                if (errors) {
                    $("#errorExplanation").show();
                }
            }
        },error: function(xhr, textStatus, errorThrown) {
            alert('Error!  Status = ' + xhr.status);
        }});
        e.preventDefault();
    });
    $("#discounts_form").submit(function(e) {
        jQuery.ajax({type: "POST",url: $(this).attr("action"),data: $(this).serialize(),success: function(response) {
            window.location.href = response.redirect;
        },error: function(xhr, textStatus, errorThrown) {
            ajax_error(xhr.responseText);
        }});
        e.preventDefault();
        return false;
    });
});
function on_activityimer_renew() {
    $.ajax('/performances/' + performance_id + '/lockings/refresh', {method: "delete",success: function(data, r, xhr) {
        eval(data);
    }});
}
function detailed_search_open() {
    return $("#otsingu-valikud").is(':visible')
}
function attach_search_event_hooks() {
    $("#open_advanced_search_link a").click(show_detailed_search);
    $("#close-detailed-search").click(hide_detailed_search);
}
function show_detailed_search_link() {
    if (!detailed_search_open()) {
        $("#open_advanced_search_link").slideDown(100);
    }
}
function show_detailed_search_link_with_delay() {
    setTimeout(show_detailed_search_link, 300);
}
function hide_detailed_search_link() {
    $("#open_advanced_search_link").slideUp(100);
}
function hide_detailed_search_link_with_delay() {
    setTimeout(hide_detailed_search_link, 200);
}
function show_detailed_search() {
    if (!detailed_search_open()) {
        $("#otsing").addClass("active");
        $("#otsing-fullname-label").show();
        $("#otsingu-valikud").show();
        hide_detailed_search_link();
    }
}
function hide_detailed_search() {
    if (detailed_search_open()) {
        $("#otsing-fullname-label").hide();
        $("#otsingu-valikud").hide();
        $("#otsing").removeClass("active");
        show_detailed_search_link();
    }
}
function attach_minu_piletimaailm_event_hooks() {
    $("#minu_piletimaailm_login_link").click(function(e) {
        $("#minu_piletimaailm_login_link").slideUp();
        $("#minu_piletimaailm_login").slideDown();
        e.stopPropagation();
        setTimeout(focus_mp_email, 200);
    });
    $('#newsletter_subscription_email').click(function(e) {
        e.stopPropagation();
    });
}
function focus_mp_email() {
    $("#minu_piletimaailm_login #email").focus();
}
jQuery(function($) {
    $.datepicker.regional['et'] = {closeText: 'Sulge',prevText: '&laquo;Tagasi',nextText: 'Edasi&raquo;',currentText: 'T&auml;na',monthNames: ['Jaanuar', 'Veebruar', 'M&auml;rts', 'Aprill', 'Mai', 'Juuni', 'Juuli', 'August', 'September', 'Oktoober', 'November', 'Detsember'],monthNamesShort: ['Jaanuar', 'Veebruar', 'M&auml;rts', 'Aprill', 'Mai', 'Juuni', 'Juuli', 'August', 'September', 'Oktoober', 'November', 'Detsember'],dayNamesShort: ['E', 'T', 'K', 'N', 'R', 'L', 'P;'],dayNames: ['P&uuml;hap&auml;ev', 'Esmasp&auml;ev', 'Teisip&auml;ev', 'Kolmap&auml;ev', 'Neljap&auml;ev', 'Reede', 'Laup&auml;ev'],dayNamesMin: ['P', 'E', 'T', 'K', 'N', 'R', 'L'],dateFormat: 'dd.mm.yy',firstDay: 1,isRTL: false};
    $.datepicker.setDefaults($.datepicker.regional['et']);
});
