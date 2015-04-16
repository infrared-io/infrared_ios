/**
 * Created by urosmil on 10/6/14.
 */

infrared.plugin("main", {
    "firstLabelData" : {
        "text" : 'IRLabel',
        "color" : '#ffffff'
    },
    "gestureRecognizer1" : function () {
        NSLog('gestureRecognizer1');
    },
    "gestureRecognizer2" : function (gestureRecognizer) {
        NSLog('gestureRecognizer2');
    },
    "button2Action" : function () {
        NSLog('button2Action');
    },
    "button3Action" : function (control, event) {
        NSLog('button3Action');
    }
});