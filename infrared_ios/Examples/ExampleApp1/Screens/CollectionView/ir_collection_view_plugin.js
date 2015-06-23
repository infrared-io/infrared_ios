
IR.plugin("collection_view", {
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