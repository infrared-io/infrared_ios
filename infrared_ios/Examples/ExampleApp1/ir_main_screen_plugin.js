
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
    "button1Action" : function () {
        this.pushViewControllerWithScreenIdAnimated('ir_table_view', true);
    },
    "button2Action" : function () {
        this.pushViewControllerWithScreenIdAnimated('ir_picker_view', true);
    },
    "button3Action" : function (control, event) {
        NSLog('button3Action');
    }
});