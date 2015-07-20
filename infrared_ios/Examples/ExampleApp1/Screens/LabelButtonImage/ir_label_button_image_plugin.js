
IR.plugin({
    "defaultButtonTapped" : function () {
        this.showAlertView(
            'Default Button', 'Tapped',
            null,
            'Cancel', ['OK'], null);
    },
    "customButtonTapped" : function (control, event) {
        this.showAlertView(
            'Custom Button', 'Tapped',
            null,
            'Cancel', ['OK'], null);
    }
});