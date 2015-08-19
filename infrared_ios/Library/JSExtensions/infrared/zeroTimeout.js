
// from url: http://ajaxian.com/archives/settimeout-delay

// Only add setZeroTimeout to the window object, and hide everything
// else in a closure.

// Only add setZeroTimeout to the window object, and hide everything
// else in a closure.
(function() {
    var timeouts = [];
    var messageName = "zero-timeout-message";

    // Like setTimeout, but only takes a function argument.  There's
    // no time argument (always zero) and no arguments (you have to
    // use a closure).
    function setZeroTimeout(fn) {
        timeouts.push(fn);
        window.postMessage(messageName, "*");
    }

    function handleMessage(event) {
        if (event.source == window && event.data == messageName) {
            event.stopPropagation();
            if (timeouts.length > 0) {
                var fn = timeouts.shift();
                fn();
            }
        }
    }

    window.addEventListener("message", handleMessage, true);

    // Add the one thing we want added to the window object.
    window.setZeroTimeout = setZeroTimeout;
})();

//(function() {
//    var timeouts = [];
//    var worker = new Worker('zeroTimeoutWorker.js');
//    worker.onmessage = function(event) {
//        //event.stopPropagation();
//        var response = event.data;
//        //console.log('data = '+response);
//        if (response == 'success') {
//            //console.log('success');
//            var func = timeouts.shift();
//            func();
//        }
//    };
//
//    function setZeroTimeout(fn) {
//        timeouts.push(fn);
//        //var worker = new Worker('zeroTimeoutWorker.js');
//        //worker.onmessage = function(event) {
//        //    //event.stopPropagation();
//        //    var response = event.data;
//        //    console.log('data = '+response);
//        //    if (response == 'success') {
//        //        //console.log('success');
//        //        var func = timeouts.shift();
//        //        func();
//        //    }
//        //};
//        //worker.addEventListener('message', function(event) {
//        //    //event.stopPropagation();
//        //    var response = event.data;
//        //    console.log('data = '+response);
//        //    if (response == 'success') {
//        //        //console.log('success');
//        //        var func = timeouts.shift();
//        //        func();
//        //    }
//        //}, false);
//        worker.postMessage("zero-timeout-message");
//    }
//
//    window.setZeroTimeout = setZeroTimeout;
//})();
