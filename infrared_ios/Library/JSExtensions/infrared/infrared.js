//
// Created by Uros Milivojevic on 2/10/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

// --------------------------------------------------------------------------------------------------------------------
// UIButtonType
var UIControlStateNormal       = 0;
var UIControlStateHighlighted  = 1;
var UIControlStateDisabled     = 2;
var UIControlStateSelected     = 4;
// --------------------------------------------------------------------------------------------------------------------

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
// UITableViewScrollPosition
var UITableViewScrollPositionNone = 0;
var UITableViewScrollPositionTop = 1;
var UITableViewScrollPositionMiddle = 2;
var UITableViewScrollPositionBottom = 3;
// --------------------------------------------------------------------------------------------------------------------

// --------------------------------------------------------------------------------------------------------------------
// UITableViewRowAnimation
var UITableViewRowAnimationFade = 0;
var UITableViewRowAnimationRight = 1;
var UITableViewRowAnimationLeft = 2;
var UITableViewRowAnimationTop = 3;
var UITableViewRowAnimationBottom = 4;
var UITableViewRowAnimationNone = 5;
var UITableViewRowAnimationMiddle = 6;
var UITableViewRowAnimationAutomatic = 100;
// --------------------------------------------------------------------------------------------------------------------

// --------------------------------------------------------------------------------------------------------------------
//
var UIScrollViewIndicatorStyleDefault = 0;
var UIScrollViewIndicatorStyleBlack = 1;
var UIScrollViewIndicatorStyleWhite = 2;
// --------------------------------------------------------------------------------------------------------------------

// --------------------------------------------------------------------------------------------------------------------
// UIGestureRecognizerState
var UIGestureRecognizerStatePossible = 0;
var UIGestureRecognizerStateBegan = 1;
var UIGestureRecognizerStateChanged = 2;
var UIGestureRecognizerStateEnded = 3;
var UIGestureRecognizerStateCancelled = 4;
var UIGestureRecognizerStateFailed = 5;
var UIGestureRecognizerStateRecognized = UIGestureRecognizerStateEnded;
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

    this.controllersMap = {};

    this.controllerName = null;
    this.nameForFollowingController = function (controllerName) {
        this.controllerName = controllerName;
    };
    this.controller = function (dictionary) {
        if (this.controllerName && this.controllerName.length>0) {
            this.controllersMap[this.controllerName] = dictionary;
            this.controllerName = null;
        }
    };

    this.getLocalStorageItems = function () {
        var data = {};
        var key;
        var value;
        for (var i = 0; i < localStorage.length; i++){
            key = localStorage.key(i);
            value = localStorage.getItem(key);
            data[key] = value;
        }
        return data;
    };

    this.setLocalStorageItems = function (data) {
        var value;
        for (var key in data){
            if (data.hasOwnProperty(key)) {
                value = data[key];
                IR.localStorageOriginalSetItem.call(localStorage, key, value);
            }
        }
    };

    this.watchJSCallback = function (prop, action, newValue, oldValue) {
        //console.log("this=" + this + ", prop=" + prop + ", action=" + action);
        //NSLog("this=" + this + ", prop=" + prop + ", action=" + action);
        this.watchJSCallbackToObjC(prop, action, newValue, oldValue);
    };

    this.extendVCWithControllerName = function (viewController, controllerNameList) {
        var controllerName;
        var controller;
        if (controllerNameList && viewController) {
            for (var i = 0; i < controllerNameList.length; i++) {
                controllerName = controllerNameList[i];
                controller = this.controllersMap[controllerName];
                if (controller != null) {
                    extend(viewController, controller, true);
                }
            }
        }
    };

    this.extendVCWithController = function (viewController, controller) {
        extend(viewController, controller, true);
    };

    // INFO:
    //      - Method taken from Class.js
    //      - extended by me to support function wrapping
    // helper for merging two object with each other
    function extend(oldObj, originalNewObj, preserve) {
        // fail-save if something goes wrong
        if(!oldObj || !originalNewObj) return oldObj || originalNewObj || {};

        // make sure we work with copies
        //oldObj = copy(oldObj);

        //var newObj = copy(originalNewObj);

        var toStringValue;
        var newObjectProperty;

        for(var key in originalNewObj) {
            toStringValue = Object.prototype.toString.call(originalNewObj[key]);
            //console.log('ir.extend '+toStringValue+' - key='+key);
            if(toStringValue === '[object Object]') {
                if (oldObj[key] === undefined) {
                    oldObj[key] = {};
                }
                //extend(oldObj[key], newObj[key]);
                newObjectProperty = copy(originalNewObj[key]);
                extend(oldObj[key], newObjectProperty);
            } else if(toStringValue === '[object Array]') {
                if (oldObj[key] === undefined) {
                    oldObj[key] = [];
                }
                //extend(oldObj[key], newObj[key]);
                newObjectProperty = copy(originalNewObj[key]);
                extend(oldObj[key], newObjectProperty);
            } else {
                if (toStringValue === '[object Function]'
                    && typeof oldObj.key !== "undefined")
                {
                    //oldObj[key] = (preserve && oldObj[key]) ? oldObj[key] : wrap(/*newObj*/originalNewObj[key], oldObj);
                    if (preserve && oldObj[key]) {
                        //oldObj[key] = oldObj[key];
                    } else {
                        oldObj[key] = wrap(originalNewObj[key], oldObj);
                    }
                } else { // [object Number], [object Boolean], [object String], [object Undefined], [object Null], [object Date], [object RegExp]
                    // if preserve is set to true oldObj will not be overwritten by newObj if
                    // oldObj has already a method key
                    if (preserve && oldObj[key]) {
                        //oldObj[key] = oldObj[key];
                    } else {
                        //oldObj[key] = newObj[key];

                        var descriptor = Object.getOwnPropertyDescriptor(originalNewObj/*newObj*/, key);
                        var aGetter;
                        var aSetter;
                        if (typeof descriptor !== "undefined") {
                            aGetter = descriptor.get;
                            aSetter = descriptor.set;
                        }
                        if ((typeof aGetter !== "undefined" && aGetter != null)
                            || (typeof aSetter !== "undefined" && aSetter != null))
                        {
                            Object.defineProperty(oldObj, key, {
                                enumerable: true,
                                get: aGetter,
                                set: aSetter
                            }); // value: 8675309, writable: false, enumerable: false
                        } else {
                            //oldObj[key] = newObj[key];
                            oldObj[key] = originalNewObj[key];
                        }
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

var IR = new infraredClass();

IR.localStorageOriginalSetItem = localStorage.setItem;
localStorage.setItem = function(a_key, a_value) {
    IR.Util.localStorageItemSet(a_key, a_value);
    IR.localStorageOriginalSetItem.call(localStorage, a_key, a_value);
};

IR.localStorageOriginalRemoveItem = localStorage.removeItem;
localStorage.removeItem = function(a_key) {
    IR.Util.localStorageItemRemove(a_key);
    IR.localStorageOriginalRemoveItem.call(localStorage, a_key);
};

IR.localStorageOriginalClear = localStorage.clear;
localStorage.clear = function() {
    IR.Util.localStorageClear();
    IR.localStorageOriginalClear.call(localStorage);
};
