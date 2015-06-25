
IR.plugin("label_button_image", {
    "defaultButtonTapped" : function () {
        this.showAlertViewWithTitleMessageActionCancelOtherButtonsData(
            'Default Button', 'Tapped',
            null,
            'Cancel', ['OK'], null);
    },
    "customButtonTapped" : function (control, event) {
        this.showAlertViewWithTitleMessageActionCancelOtherButtonsData(
            'Custom Button', 'Tapped',
            null,
            'Cancel', ['OK'], null);
    }
});