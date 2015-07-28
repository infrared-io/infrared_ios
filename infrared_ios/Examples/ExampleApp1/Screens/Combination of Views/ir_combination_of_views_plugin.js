
IR.plugin({
    "firstLabelData" : {
        "text" : 'IR-Label',
        //get text() {
        //    return labelValue;
        //},
        //set text(value) {
        //    labelValue = value;
        //},
        "data": {
            "first": "a Label value"
        },
        //get data() {
        //    return labelData;
        //},
        //set data(data) {
        //    labelData = data;
        //},
        "color" : '#ffffff'
    },
    "barButtonItemAction": function (control) {
        NSLog('Combination of views - barButtonItemAction');
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