

IR.plugin("starting_screen", {
    "tableViewRowSelected" : function (tableView, indexPath, data) {
        if (data.screenId && data.screenId.length > 0) {
            this.pushViewControllerWithScreenIdAnimated(data.screenId, true);
        }
    },
    "tableData" : [
        {
            "cells" : [
                {
                    "text" : "Gesture Recognizers",
                    "screenId" : "ir_gesture_recognizers"
                },
                {
                    "text" : "Table View",
                    "screenId" : "ir_table_view"
                },
                {
                    "text" : "Picker View",
                    "screenId" : "ir_picker_view"
                },
                {
                    "text" : "Combination of Views",
                    "screenId" : "ir_combination_of_views"
                }
            ]
        }
    ]
});