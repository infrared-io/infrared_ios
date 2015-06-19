

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
    "longPressGestureRecognizer": function (gestureRecognizer) {
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            this.showAlertViewWithTitleMessageActionCancelOtherButtonsData(
                'Long Press Gesture Recognizer', "Long Press",
                null,
                'OK', [], null);
        }
    },
    "pinchGestureRecognizer": function (gestureRecognizer) {
        //console.log('state='+gestureRecognizer.state);
        if (UIGestureRecognizerStateBegan == gestureRecognizer.state ||
            UIGestureRecognizerStateChanged == gestureRecognizer.state)
        {
            //console.log('scale='+gestureRecognizer.scale);
            this.pinchGestureScale = ''+gestureRecognizer.scale;
            this.updateComponentsWithDataBindingKey('pinchGestureScale');
        }
    },
    "rotationGestureRecognizer": function (gestureRecognizer) {
        if (UIGestureRecognizerStateBegan == gestureRecognizer.state ||
            UIGestureRecognizerStateChanged == gestureRecognizer.state)
        {
            //console.log('scale='+gestureRecognizer.scale);
            this.rotationGestureRotationAndVelocity = ''+gestureRecognizer.rotation+', '+gestureRecognizer.velocity;
            this.updateComponentsWithDataBindingKey('rotationGestureRotationAndVelocity');
        }
    },
    "panGestureRecognizer": function (gestureRecognizer) {
        gestureRecognizer.view.center = gestureRecognizer.locationInView(gestureRecognizer.view.superview);
    },
    "screenEdgePanGestureRecognizer": function (gestureRecognizer) {
        if (UIGestureRecognizerStateBegan == gestureRecognizer.state)
        {
            this.showAlertViewWithTitleMessageActionCancelOtherButtonsData(
                'Screen Edge Pan Gesture Recognizer', "Right Screen Edge Pan",
                null,
                'OK', [], null);
        }
    },
    "pinchGestureScale": "1",
    "rotationGestureRotationAndVelocity": "1,1"
});