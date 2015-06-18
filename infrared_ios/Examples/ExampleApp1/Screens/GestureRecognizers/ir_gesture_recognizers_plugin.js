

IR.plugin("gesture_recognizers", {
    "tapGestureRecognizer": function () {
        this.showAlertViewWithTitleMessageActionCancelOtherButtonsData(
            'Tap Gesture Recognizer', "Single Tap",
            null,
            'OK', [], null);
    },
    "doubleTapGestureRecognizer": function () {
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

    "pinchGestureRecognizer": function () {

    }
});