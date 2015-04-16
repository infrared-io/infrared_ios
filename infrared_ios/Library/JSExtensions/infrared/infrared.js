/**
 * Created by urosmil on 2/10/15.
 */

// --------------------------------------------------------------------------------------------------------------------
// UIButtonType
var UIButtonTypeCustom = 0;
var UIButtonTypeSystem = 1;
var UIButtonTypeDetailDisclosure = 2;
var UIButtonTypeInfoLight = 3;
var UIButtonTypeInfoDark = 4;
var UIButtonTypeContactAdd = 5;
// --------------------------------------------------------------------------------------------------------------------

// --------------------------------------------------------------------------------------------------------------------
// UITableViewStyle
var UITableViewStylePlain = 0;
var UITableViewStyleGrouped = 1;
// --------------------------------------------------------------------------------------------------------------------

// --------------------------------------------------------------------------------------------------------------------
var CGRectZero = {
    "x": 0,
    "y": 0,
    "width": 0,
    "height": 0
};
var CGPointZero = {
    "x": 0,
    "y": 0
};
var CGSizeZero = {
    "width": 0,
    "height": 0
};
var UIEdgeInsetsZero = {
    "top": 0,
    "left": 0,
    "bottom": 0,
    "right": 0
};
// --------------------------------------------------------------------------------------------------------------------

var Global = this;

var infraredClass = function () {

    this.pluginsMap = {};

    this.plugin = function (name, dictionary) {
        this.pluginsMap[name] = dictionary;
    };

    //this.addWatch = function (viewController, propertyName, numberOfLevels) {
    //    if (viewController) {
    //        setTimeout((function(viewController, propertyName, numberOfLevels) {
    //            watch(viewController, propertyName, infrared.watchJSCallback, numberOfLevels);
    //        })(viewController, propertyName, numberOfLevels), 1);
    //        //watch(viewController, propertyName, infrared.watchJSCallback, numberOfLevels);
    //    } else {
    //        NSLog("ERROR: infrared.addWatch - viewController is NULL !!!!!!");
    //    }
    //};
    //
    //this.removeWatch = function (viewController, propertyName) {
    //    unwatch(viewController, propertyName, infrared.watchJSCallback);
    //};

    this.watchJSCallback = function (prop, action, newValue, oldValue) {
        //console.log("this=" + this + ", prop=" + prop + ", action=" + action);
        //NSLog("this=" + this + ", prop=" + prop + ", action=" + action);
        this.watchJSCallbackToObjC(prop, action, newValue, oldValue);
    };

    this.extendVCWithPluginName = function (viewController, pluginName) {
        var plugin = null;
        for (var anPluginName in this.pluginsMap) {
            if (anPluginName == pluginName) {
                plugin = this.pluginsMap[anPluginName];
                break;
            }
        }

        if (plugin != null) {
            extend(viewController, plugin, true);
        }
    };

    this.extendVCWithPlugin = function (viewController, plugin) {
        extend(viewController, plugin, true);
    };

    // INFO:
    //      - Method taken from Class.js
    //      - extended by me to support function wrapping
    // helper for merging two object with each other
    function extend(oldObj, newObj, preserve) {
        // failsave if something goes wrong
        if(!oldObj || !newObj) return oldObj || newObj || {};

        // make sure we work with copies
        //oldObj = copy(oldObj);
        newObj = copy(newObj);

        for(var key in newObj) {
            if(Object.prototype.toString.call(newObj[key]) === '[object Object]') {
                if (oldObj[key] === undefined) {
                    oldObj[key] = {};
                }
                extend(oldObj[key], newObj[key]);
            } else {
                if (Object.prototype.toString.call(newObj[key]) === '[object Function]'
                    && typeof oldObj.key !== "undefined")
                {
                    //console.log('-- function "' + key + '" wrapped --');
                    oldObj[key] = (preserve && oldObj[key]) ? oldObj[key] : wrap(newObj[key], oldObj);
                } else {
                    // if preserve is set to true oldObj will not be overwritten by newObj if
                    // oldObj has already a method key
                    if (preserve && oldObj[key]) {
                        //oldObj[key] = oldObj[key];
                    } else {
                        oldObj[key] = newObj[key];
                    }
                }
            }
        }

        return oldObj;
    }

    // INFO:
    //      - Method taken from Class.js
    // helper for assigning methods to a new prototype
    function copy(obj) {
        var F = function () {};
        F.prototype = obj.prototype || obj;
        return new F();
    }

    function wrap(fn, viewController){
        return function(){
            return fn.apply(viewController, arguments);
        };
    }

};

var infrared = new infraredClass();
