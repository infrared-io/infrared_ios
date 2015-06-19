

IR.plugin("gesture_recognizers", {
    "tapGestureRecognizer": function (gestureRecognizer) {
        this.showAlertViewWithTitleMessageActionCancelOtherButtonsData(
            'Tap Gesture Recognizer', "Single Tap",
            null,
            'OK', [], null);
    },
    "doubleTapGestureRecognizer": function (gestureRecognizer) {
        this.showAlertViewWithTitleMessageActionCancelOtherButtonsData(
            'Tap Gesture Recognizer', "Double Tap",
            null,
            'OK', [], null);
    },
    "leftSwipeGestureRecognizer": function (gestureRecognizer) {
        this.showAlertViewWithTitleMessageActionCancelOtherButtonsData(
            'Swipe Gesture Recognizer', "Left Swipe",
            null,
            'OK', [], null);
    },
    "rightSwipeGestureRecognizer": function (gestureRecognizer) {
        this.showAlertViewWithTitleMessageActionCancelOtherButtonsData(
            'Swipe Gesture Recognizer', "Right Swipe",
            null,
            'OK', [], null);
    },
    "pinchGestureRecognizer": function (gestureRecognizer) {
        //console.log('state='+gestureRecognizer.state);
        if (UIGestureRecognizerStateBegan == gestureRecognizer.state ||
            UIGestureRecognizerStateChanged == gestureRecognizer.state)
        {
            console.log('scale='+gestureRecognizer.scale);
            this.pinchGestureScale = ''+gestureRecognizer.scale;
            this.updateComponentsWithDataBindingKey('pinchGestureScale');
        }
    },
    "pinchGestureScale": "1"
});