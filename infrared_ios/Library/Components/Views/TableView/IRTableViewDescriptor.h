//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewDescriptor.h"
#import "IRScrollViewDescriptor.h"


@interface IRTableViewDescriptor : IRScrollViewDescriptor

@property (nonatomic) UITableViewStyle                     style;

@property (nonatomic)          CGFloat                     rowHeight;             // will return the default value if unset
@property (nonatomic)          CGFloat                     sectionHeaderHeight;   // will return the default value if unset
@property (nonatomic)          CGFloat                     sectionFooterHeight;   // will return the default value if unset
@property (nonatomic)          CGFloat                     estimatedRowHeight NS_AVAILABLE_IOS(7_0); // default is 0, which means there is no estimate
@property (nonatomic)          CGFloat                     estimatedSectionHeaderHeight NS_AVAILABLE_IOS(7_0); // default is 0, which means there is no estimate
@property (nonatomic)          CGFloat                     estimatedSectionFooterHeight NS_AVAILABLE_IOS(7_0); // default is 0, which means there is no estimate
@property (nonatomic)          UIEdgeInsets                separatorInset NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR; // allows customization of the frame of cell separators

@property(nonatomic, readwrite, retain) IRViewDescriptor *backgroundView NS_AVAILABLE_IOS(3_2); // the background view will be automatically resized to track the size of the table view.  this will be placed as a subview of the table view behind all cells and headers/footers.  default may be non-nil for some devices.

@property (nonatomic/*, getter=isEditing*/) BOOL editing;                             // default is NO. setting is not animated.

@property (nonatomic) BOOL allowsSelection NS_AVAILABLE_IOS(3_0);  // default is YES. Controls whether rows can be selected when not in editing mode
@property (nonatomic) BOOL allowsSelectionDuringEditing;                                     // default is NO. Controls whether rows can be selected when in editing mode
@property (nonatomic) BOOL allowsMultipleSelection NS_AVAILABLE_IOS(5_0);                 // default is NO. Controls whether multiple rows can be selected simultaneously
@property (nonatomic) BOOL allowsMultipleSelectionDuringEditing NS_AVAILABLE_IOS(5_0);   // default is NO. Controls whether multiple rows can be selected simultaneously in editing mode

@property (nonatomic) NSInteger sectionIndexMinimumDisplayRowCount;                                                      // show special section index list on right when row count reaches this value. default is 0
@property (nonatomic, retain) UIColor *sectionIndexColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;                   // color used for text of the section index
@property (nonatomic, retain) UIColor *sectionIndexBackgroundColor NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;         // the background color of the section index while not being touched
@property (nonatomic, retain) UIColor *sectionIndexTrackingBackgroundColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR; // the background color of the section index while it is being touched

@property (nonatomic) UITableViewCellSeparatorStyle separatorStyle; // default is UITableViewCellSeparatorStyleSingleLine
@property (nonatomic, retain) UIColor              *separatorColor UI_APPEARANCE_SELECTOR; // default is the standard separator gray

@property (nonatomic, retain) IRViewDescriptor *tableHeaderView;                           // accessory view for above row content. default is nil. not to be confused with section header
@property (nonatomic, retain) IRViewDescriptor *tableFooterView;                           // accessory view below content. default is nil. not to be confused with section footer

@property(nonatomic,retain) NSMutableArray *sectionHeadersArray;
@property(nonatomic,retain) NSMutableArray *sectionFootersArray;
@property(nonatomic,retain) NSMutableArray *cellsArray;

@property (nonatomic, strong) NSString *sectionItemName;
@property (nonatomic, strong) NSString *cellItemName;

@property (nonatomic, strong) NSString *selectRowAction;
@property (nonatomic) BOOL             disableSelectRowAction;
@property (nonatomic, strong) NSString *accessoryButtonAction;

@property (nonatomic, strong) NSArray *tableData;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end