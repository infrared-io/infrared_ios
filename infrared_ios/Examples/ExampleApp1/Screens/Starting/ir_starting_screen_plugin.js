

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
                    "text" : "Alert View and Action Sheet",
                    "screenId" : "ir_alert_view_and_action_sheet"
                },
                //{
                //    "text" : "Label, Button, Image",
                //    "screenId" : ""
                //},
                //{
                //    "text" : "TextField, TextView",
                //    "screenId" : ""
                //},
                //{
                //    "text" : "SegmentedControl, Slider, Stepper, Switch",
                //    "screenId" : ""
                //},
                //{
                //    "text" : "PageControl",
                //    "screenId" : ""
                //},
                {
                    "text" : "Table View",
                    "screenId" : "ir_table_view"
                },
                {
                    "text" : "Collection View",
                    "screenId" : "ir_collection_view"
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