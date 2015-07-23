
IR.plugin({
    "showMyAlertView" : function () {
        this.showAlertView(
            'Alert View', 'Some question or message',
            'this.showAlertViewResponse(alertView, buttonIndex);',
            'Cancel', ['OK'], null);
    },
    "showAlertViewResponse" : function (alertView, buttonIndex) {
        if (buttonIndex == 1) {
            NSLog('showAlertViewResponse - OK!');
        }
    },
    "showMyActionSheet": function () {
        this.showActionSheet(
            'Action Sheet',
            'this.showActionSheetResponse(actionSheet, buttonIndex);',
            'Cancel', 'Destroy', ['First', 'Second', 'Third'], null);
    },
    "showActionSheetResponse": function (actionSheet, buttonIndex) {
        if (buttonIndex > 3) { // Cancel button
            NSLog('showActionSheetResponse - Cancel!');
        }
        switch (buttonIndex) {
            case 0: // Destroy
                NSLog('showActionSheetResponse - Destroy!');
                break;
            case 1: // First
                NSLog('showActionSheetResponse - First!');
                break;
            case 2: // Second
                NSLog('showActionSheetResponse - Second!');
                break;
            case 3: // Third
                NSLog('showActionSheetResponse - Third!');
                break;
        }
    }
});