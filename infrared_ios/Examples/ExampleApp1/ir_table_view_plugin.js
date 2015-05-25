
infrared.plugin("table_view", {
    "updateSectionOne" : function () {
        this.tableData[0].sectionHeader.title = 'Section header 1+';
        this.tableData[0].sectionFooter.title = 'Section footer 1+';
        this.updateComponentsWithDataBindingKey('tableData');

        this.tableHeader = {
            "text1" : "Header title +",
            "text2" : "Header description +"
        };
    },
    "tableHeader" : {
        "text1" : "Header title",
        "text2" : "Header description description description description description"
    },
    "tableFooter" : {
        "text1" : "Footer title",
        "text2" : "Footer description"
    },
    "tableData" : [
        {
            "sectionHeader" : {
                "title" : "Section header 1"
            },
            "sectionFooter" : {
                "title" : "Section footer 1"
            },
            "cells" : [
                {
                    "cellId" : "cell1",
                    "rowHeight" : 100,
                    "imagePath" : "",
                    "name" : "Name 1",
                    "description" : "Very Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Long Description 1"
                },
                {
                    "imagePath" : "",
                    "name" : "Name Name Name Name Name Name 2",
                    "description" : "Description 2"
                }
            ]
        },
        {
            "cells" : [
                {
                    "cellId" : "cell_plain_1",
                    "text" : "style: UITableViewCellStyleDefault"
                },
                {
                    "cellId" : "cell_plain_2",
                    "text" : "style",
                    "details" : "UITableViewCellStyleValue1",
                    "detailsFont" : "SystemItalic, 13"
                },
                {
                    "cellId" : "cell_plain_3",
                    "text" : "style",
                    "details" : "UITableViewCellStyleValue2"
                },
                {
                    "cellId" : "cell_plain_4",
                    "text" : "style",
                    "details" : "UITableViewCellStyleSubtitle"
                }
            ]
        },
        {
            "sectionHeader" : {
                "sectionId" : "tableSectionHeaderView1",
                "sectionHeaderHeight" : 70,
                "title" : "Section header 2"
            },
            "sectionFooter" : {
                "sectionId" : "tableSectionFooterView1",
                "sectionFooterHeight" : 50,
                "title" : "Section footer 2"
            },
            "cells" : [
                {
                    "cellId" : "cell1",
                    "rowHeight" : 75,
                    "imagePath" : "",
                    "name" : "Name 3",
                    "description" : "Description 3"
                },
                {
                    "cellId" : "cell1",
                    "imagePath" : "",
                    "name" : "Name 4",
                    "description" : "Description 4"
                },
                {
                    "cellId" : "cell1",
                    "imagePath" : "",
                    "name" : "Name 4-1",
                    "description" : "Description 4"
                },
                {
                    "cellId" : "cell1",
                    "imagePath" : "",
                    "name" : "Name 4-2",
                    "description" : "Description 4"
                },
                {
                    "cellId" : "cell1",
                    "imagePath" : "",
                    "name" : "Name 4-3",
                    "description" : "Description 4"
                },
                {
                    "cellId" : "cell1",
                    "imagePath" : "",
                    "name" : "Name 4-4",
                    "description" : "Description 4"
                },
                {
                    "cellId" : "cell1",
                    "imagePath" : "",
                    "name" : "Name 4-5",
                    "description" : "Description 4"
                },
                {
                    "cellId" : "cell1",
                    "imagePath" : "",
                    "name" : "Name 4-6",
                    "description" : "Description 4"
                },
                {
                    "cellId" : "cell1",
                    "imagePath" : "",
                    "name" : "Name 4-7",
                    "description" : "Description 4"
                }
            ]
        }
    ]
});