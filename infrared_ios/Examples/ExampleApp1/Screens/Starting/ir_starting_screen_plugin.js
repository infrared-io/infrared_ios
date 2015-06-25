

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
                    "text" : "AlertView and ActionSheet",
                    "screenId" : "ir_alert_view_and_action_sheet"
                },
                {
                    "text" : "Label, Button, Image",
                    "screenId" : "ir_label_button_image"
                },
                //{
                //    "text" : "View, ScrollView, PageControl",
                //    "screenId" : ""
                //},
                //{
                //    "text" : "MapView, WebView",
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
                //    "text" : "ProgressView, Toolbar, SearchBar",
                //    "screenId" : ""
                //},
                //{
                //    "text" : "DataPicker",
                //    "screenId" : "ir_data_picker"
                //},
                {
                    "text" : "TableView",
                    "screenId" : "ir_table_view"
                },
                {
                    "text" : "CollectionView",
                    "screenId" : "ir_collection_view"
                },
                {
                    "text" : "PickerView, DataPicker",
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