/**
 * Created by urosmil on 5/27/15.
 */

self.addEventListener('message', function(event) {
    if (event.data == 'zero-timeout-message') {
        self.postMessage("success");
    } else {
        self.postMessage("failure");
    }
}, false);