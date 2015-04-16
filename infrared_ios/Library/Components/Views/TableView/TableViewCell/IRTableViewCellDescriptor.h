//
// Created by Uros Milivojevic on 12/12/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewDescriptor.h"


@interface IRTableViewCellDescriptor : IRViewDescriptor

@property (nonatomic) UITableViewCellStyle style;

// Default is nil for cells in UITableViewStylePlain, and non-nil for UITableViewStyleGrouped. The 'backgroundView' will be added as a subview behind all other views.
@property (nonatomic, retain) IRViewDescriptor       *backgroundView;

// Default is nil for cells in UITableViewStylePlain, and non-nil for UITableViewStyleGrouped. The 'selectedBackgroundView' will be added as a subview directly above the backgroundView if not nil, or behind all other views. It is added as a subview only when the cell is selected. Calling -setSelected:animated: will cause the 'selectedBackgroundView' to animate in and out with an alpha fade.
@property (nonatomic, retain) IRViewDescriptor       *selectedBackgroundView;

// If not nil, takes the place of the selectedBackgroundView when using multiple selection.
@property (nonatomic, retain) IRViewDescriptor       *multipleSelectionBackgroundView NS_AVAILABLE_IOS(5_0);

@property (nonatomic) UITableViewCellSelectionStyle   selectionStyle;             // default is UITableViewCellSelectionStyleBlue.
@property (nonatomic/*, getter=isSelected*/) BOOL     selected;                   // set selected state (title, image, background). default is NO. animated is NO
@property (nonatomic/*, getter=isHighlighted*/) BOOL  highlighted;                // set highlighted state (title, image, background). default is NO. animated is NO

@property (nonatomic) UITableViewCellEditingStyle     editingStyle;

@property (nonatomic) BOOL                            showsReorderControl;        // default is NO
@property (nonatomic) BOOL                            shouldIndentWhileEditing;   // default is YES.  This is unrelated to the indentation level below.

@property (nonatomic) UITableViewCellAccessoryType    accessoryType;              // default is UITableViewCellAccessoryNone. use to set standard type
@property (nonatomic, retain) IRViewDescriptor       *accessoryView;              // if set, use custom view. ignore accessoryType. tracks if enabled can calls accessory action
@property (nonatomic) UITableViewCellAccessoryType    editingAccessoryType;       // default is UITableViewCellAccessoryNone. use to set standard type
@property (nonatomic, retain) IRViewDescriptor       *editingAccessoryView;       // if set, use custom view. ignore editingAccessoryType. tracks if enabled can calls accessory action

@property (nonatomic) NSInteger                       indentationLevel;           // adjust content indent. default is 0
@property (nonatomic) CGFloat                         indentationWidth;           // width for each level. default is 10.0
@property (nonatomic) UIEdgeInsets                    separatorInset NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR; // allows customization of the separator frame

@property (nonatomic/*, getter=isEditing*/) BOOL          editing;                    // show appropriate edit controls (+/- & reorder). By default -setEditing: calls setEditing:animated: with NO for animated.

@property (nonatomic, strong) NSString               *selectRowAction;
@property (nonatomic, strong) NSString               *accessoryButtonAction;
@property (nonatomic) BOOL                            disableSelectRowAction;

@property (nonatomic) CGFloat rowHeight;

@end