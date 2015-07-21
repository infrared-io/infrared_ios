//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRView.h"
#import "UITableViewCellExport.h"

@protocol IRTableViewCellExport <JSExport>

//// Content.  These properties provide direct access to the internal version and image views used by the table view cell.  These should be used instead of the content properties below.
//@property (nonatomic, readonly, retain) UIImageView *imageView NS_AVAILABLE_IOS(3_0);   // default is nil.  image view will be created if necessary.
//
//@property (nonatomic, readonly, retain) UILabel     *textLabel NS_AVAILABLE_IOS(3_0);   // default is nil.  version will be created if necessary.
//@property (nonatomic, readonly, retain) UILabel     *detailTextLabel NS_AVAILABLE_IOS(3_0); // default is nil.  version will be created if necessary (and the current style supports a detail version).
//
//// If you want to customize cells by simply adding additional views, you should add them to the content view so they will be positioned appropriately as the cell transitions into and out of editing mode.
//@property (nonatomic, readonly, retain) UIView      *contentView;
//
//// Default is nil for cells in UITableViewStylePlain, and non-nil for UITableViewStyleGrouped. The 'backgroundView' will be added as a subview behind all other views.
//@property (nonatomic, retain) UIView                *backgroundView;
//
//// Default is nil for cells in UITableViewStylePlain, and non-nil for UITableViewStyleGrouped. The 'selectedBackgroundView' will be added as a subview directly above the backgroundView if not nil, or behind all other views. It is added as a subview only when the cell is selected. Calling -setSelected:animated: will cause the 'selectedBackgroundView' to animate in and out with an alpha fade.
//@property (nonatomic, retain) UIView                *selectedBackgroundView;
//
//// If not nil, takes the place of the selectedBackgroundView when using multiple selection.
//@property (nonatomic, retain) UIView                *multipleSelectionBackgroundView NS_AVAILABLE_IOS(5_0);
//
//@property (nonatomic, readonly, copy) NSString      *reuseIdentifier;
//- (void)prepareForReuse;                                                        // if the cell is reusable (has a reuse identifier), this is called just before the cell is returned from the table view method dequeueReusableCellWithIdentifier:.  If you override, you MUST call super.
//
//@property (nonatomic) UITableViewCellSelectionStyle   selectionStyle;             // default is UITableViewCellSelectionStyleBlue.
//@property (nonatomic, getter=isSelected) BOOL         selected;                   // set selected state (title, image, background). default is NO. animated is NO
//@property (nonatomic, getter=isHighlighted) BOOL      highlighted;                // set highlighted state (title, image, background). default is NO. animated is NO
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated;                     // animate between regular and selected state
//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;               // animate between regular and highlighted state
//
//@property (nonatomic, readonly) UITableViewCellEditingStyle editingStyle;         // default is UITableViewCellEditingStyleNone. This is set by UITableView using the delegate's value for cells who customize their appearance accordingly.
//@property (nonatomic) BOOL                            showsReorderControl;        // default is NO
//@property (nonatomic) BOOL                            shouldIndentWhileEditing;   // default is YES.  This is unrelated to the indentation level below.
//
//@property (nonatomic) UITableViewCellAccessoryType    accessoryType;              // default is UITableViewCellAccessoryNone. use to set standard type
//@property (nonatomic, retain) UIView                 *accessoryView;              // if set, use custom view. ignore accessoryType. tracks if enabled can calls accessory action
//@property (nonatomic) UITableViewCellAccessoryType    editingAccessoryType;       // default is UITableViewCellAccessoryNone. use to set standard type
//@property (nonatomic, retain) UIView                 *editingAccessoryView;       // if set, use custom view. ignore editingAccessoryType. tracks if enabled can calls accessory action
//
//@property (nonatomic) NSInteger                       indentationLevel;           // adjust content indent. default is 0
//@property (nonatomic) CGFloat                         indentationWidth;           // width for each level. default is 10.0
//@property (nonatomic) UIEdgeInsets                    separatorInset NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR; // allows customization of the separator frame
//
//@property (nonatomic, getter=isEditing) BOOL          editing;                    // show appropriate edit controls (+/- & reorder). By default -setEditing: calls setEditing:animated: with NO for animated.
//- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
//
//@property(nonatomic, readonly) BOOL                   showingDeleteConfirmation;  // currently showing "Delete" button
//
//// These methods can be used by subclasses to animate additional changes to the cell when the cell is changing state
//// Note that when the cell is swiped, the cell will be transitioned into the UITableViewCellStateShowingDeleteConfirmationMask state,
//// but the UITableViewCellStateShowingEditControlMask will not be set.
//- (void)willTransitionToState:(UITableViewCellStateMask)state NS_AVAILABLE_IOS(3_0);
//- (void)didTransitionToState:(UITableViewCellStateMask)state NS_AVAILABLE_IOS(3_0);

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRTableViewCell : UITableViewCell <IRComponentInfoProtocol, UITableViewCellExport, IRTableViewCellExport, UIViewExport, IRViewExport>

@end