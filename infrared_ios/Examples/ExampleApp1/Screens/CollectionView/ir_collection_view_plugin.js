
IR.controller({
    "selectItem1": function (data, collectionView, indexPath) {
        NSLog('selectItem1');
    },
    "selectItem2": function (data, collectionView, indexPath) {
        NSLog('selectItem2');
    },
    "collectionData" : [
        {
            "sectionEdgeInsets": {
                "top": 8,
                "left": 16,
                "bottom": 8,
                "right": 16
            },
            "sectionHeader" : {
                "sectionId" : "section_header_1",
                "sectionHeaderHeight" : 50,
                "title" : "Section header 2"
            },
            "sectionFooter" : {
                "sectionId" : "section_footer_1",
                "sectionFooterHeight" : 50,
                "title" : "Section footer 2"
            },
            "cells": [
                {
                    "a": "b",
                    "cellSize": {
                        "width": 30,
                        "height": 30
                    }
                },
                {
                    "a": "b"
                },
                {
                    "a": "b"
                }
            ]
        },
        {
            "cells": [
                {
                    "a": "b",
                    "cellSize": {
                        "width": 200,
                        "height": 200
                    }
                },
                {
                    "a": "b"
                },
                {
                    "a": "b"
                }
            ]
        },
        {
            "cells": [
                {
                    "a": "b",
                    "cellSize": {
                        "width": 200,
                        "height": 200
                    }
                },
                {
                    "a": "b"
                },
                {
                    "a": "b"
                }
            ]
        },
        {
            "cells": [
                {
                    "a": "b",
                    "cellSize": {
                        "width": 200,
                        "height": 200
                    }
                },
                {
                    "a": "b"
                },
                {
                    "a": "b"
                }
            ]
        }
    ]
});