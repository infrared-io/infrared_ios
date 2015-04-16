
// from url: http://ajaxian.com/archives/settimeout-delay

// Only add setZeroTimeout to the window object, and hide everything
// else in a closure.
(function() {
    var timeouts = [];
    var messageName = "zero-timeout-message";
    var messageNameBack = "zero-timeout-message-back";

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
                //event.source.postMessage(messageNameBack, "*");
            }
        }
    }

    //function handleMessageOnMainThread(event) {
    //    if (event.source == window && event.data == messageNameBack) {
    //        event.stopPropagation();
    //        if (timeouts.length > 0) {
    //            var fn = timeouts.shift();
    //            fn();
    //        }
    //    }
    //}

    window.addEventListener("message", handleMessage, true);
    //window.addEventListener("message", handleMessageOnMainThread, true);

    // Add the one thing we want added to the window object.
    window.setZeroTimeout = setZeroTimeout;
})();