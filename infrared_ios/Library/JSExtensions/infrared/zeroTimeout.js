
// from url: http://ajaxian.com/archives/settimeout-delay

// Only add setZeroTimeout to the window object, and hide everything
// else in a closure.
(function() {
    var timeouts = [];
    var worker = new Worker('zeroTimeoutWorker.js');
    worker.onmessage = function(event) {
        //event.stopPropagation();
        var response = event.data;
        //console.log('data = '+response);
        if (response == 'success') {
            //console.log('success');
            var func = timeouts.shift();
            func();
        }
    };

    function setZeroTimeout(fn) {
        timeouts.push(fn);
        //var worker = new Worker('zeroTimeoutWorker.js');
        //worker.onmessage = function(event) {
        //    //event.stopPropagation();
        //    var response = event.data;
        //    console.log('data = '+response);
        //    if (response == 'success') {
        //        //console.log('success');
        //        var func = timeouts.shift();
        //        func();
        //    }
        //};
        //worker.addEventListener('message', function(event) {
        //    //event.stopPropagation();
        //    var response = event.data;
        //    console.log('data = '+response);
        //    if (response == 'success') {
        //        //console.log('success');
        //        var func = timeouts.shift();
        //        func();
        //    }
        //}, false);
        worker.postMessage("zero-timeout-message");
    }

    window.setZeroTimeout = setZeroTimeout;
})();
