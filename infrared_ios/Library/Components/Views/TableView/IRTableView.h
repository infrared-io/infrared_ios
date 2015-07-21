//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRScrollView.h"
#import "IRAutoLayoutSubComponentsProtocol.h"
#import "UITableViewExport.h"

@class IRTableViewObserver;


@protocol IRTableViewExport <JSExport>

//@property (nonatomic, readonly) UITableViewStyle           style;
//@property (nonatomic, assign)   id <UITableViewDataSource> dataSource;
//@property (nonatomic, assign)   id <UITableViewDelegate>   delegate;
//@property (nonatomic)          CGFloat                     rowHeight;             // will return the default value if unset
//@property (nonatomic)          CGFloat                     sectionHeaderHeight;   // will return the default value if unset
//@property (nonatomic)          CGFloat                     sectionFooterHeight;   // will return the default value if unset
//@property (nonatomic)          CGFloat                     estimatedRowHeight NS_AVAILABLE_IOS(7_0); // default is 0, which means there is no estimate
//@property (nonatomic)          CGFloat                     estimatedSectionHeaderHeight NS_AVAILABLE_IOS(7_0); // default is 0, which means there is no estimate
//@property (nonatomic)          CGFloat                     estimatedSectionFooterHeight NS_AVAILABLE_IOS(7_0); // default is 0, which means there is no estimate
//@property (nonatomic)          UIEdgeInsets                separatorInset NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR; // allows customization of the frame of cell separators
//
//@property(nonatomic, readwrite, retain) UIView *backgroundView NS_AVAILABLE_IOS(3_2); // the background view will be automatically resized to track the size of the table view.  this will be placed as a subview of the table view behind all cells and headers/footers.  default may be non-nil for some devices.
//
//// Data
//
//- (void)reloadData;                 // reloads everything from scratch. redisplays visible rows. because we only keep info about visible rows, this is cheap. will adjust offset if table shrinks
//- (void)reloadSectionIndexTitles NS_AVAILABLE_IOS(3_0);   // reloads the index bar.
//
//// Info
//
//- (NSInteger)numberOfSections;
//- (NSInteger)numberOfRowsInSection:(NSInteger)section;
//
//- (CGRect)rectForSection:(NSInteger)section;                                    // includes header, footer and all rows
//- (CGRect)rectForHeaderInSection:(NSInteger)section;
//- (CGRect)rectForFooterInSection:(NSInteger)section;
//- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)indexPath;
//
//- (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point;                         // returns nil if point is outside of any row in the table
//- (NSIndexPath *)indexPathForCell:(UITableViewCell *)cell;                      // returns nil if cell is not visible
//- (NSArray *)indexPathsForRowsInRect:(CGRect)rect;                              // returns nil if rect not valid
//
//- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;            // returns nil if cell is not visible or index path is out of range
//- (NSArray *)visibleCells;
//- (NSArray *)indexPathsForVisibleRows;
//- (UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (UITableViewHeaderFooterView *)footerViewForSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//
//- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
//- (void)scrollToNearestSelectedRowAtScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
//
//// Row insertion/deletion/reloading.
//
//- (void)beginUpdates;   // allow multiple insert/delete of rows and sections to be animated simultaneously. Nestable
//- (void)endUpdates;     // only call insert/delete/reload calls or change the editing state inside an update block.  otherwise things like row count, etc. may be invalid.
//
//- (void)insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;
//- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;
//- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation NS_AVAILABLE_IOS(3_0);
//- (void)moveSection:(NSInteger)section toSection:(NSInteger)newSection NS_AVAILABLE_IOS(5_0);
//
//- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
//- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
//- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation NS_AVAILABLE_IOS(3_0);
//- (void)moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath NS_AVAILABLE_IOS(5_0);
//
//// Editing. When set, rows show insert/delete/reorder controls based on data source queries
//
//@property (nonatomic, getter=isEditing) BOOL editing;                             // default is NO. setting is not animated.
//- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
//
//@property (nonatomic) BOOL allowsSelection NS_AVAILABLE_IOS(3_0);  // default is YES. Controls whether rows can be selected when not in editing mode
//@property (nonatomic) BOOL allowsSelectionDuringEditing;                                     // default is NO. Controls whether rows can be selected when in editing mode
//@property (nonatomic) BOOL allowsMultipleSelection NS_AVAILABLE_IOS(5_0);                 // default is NO. Controls whether multiple rows can be selected simultaneously
//@property (nonatomic) BOOL allowsMultipleSelectionDuringEditing NS_AVAILABLE_IOS(5_0);   // default is NO. Controls whether multiple rows can be selected simultaneously in editing mode
//
//// Selection
//
//- (NSIndexPath *)indexPathForSelectedRow;                                                // returns nil or index path representing section and row of selection.
//- (NSArray *)indexPathsForSelectedRows NS_AVAILABLE_IOS(5_0); // returns nil or a set of index paths representing the sections and rows of the selection.
//
//// Selects and deselects rows. These methods will not call the delegate methods (-tableView:willSelectRowAtIndexPath: or tableView:didSelectRowAtIndexPath:), nor will it send out a notification.
//- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;
//- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
//
//// Appearance
//
//@property (nonatomic) NSInteger sectionIndexMinimumDisplayRowCount;                                                      // show special section index list on right when row count reaches this value. default is 0
//@property (nonatomic, retain) UIColor *sectionIndexColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;                   // color used for text of the section index
//@property (nonatomic, retain) UIColor *sectionIndexBackgroundColor NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;         // the background color of the section index while not being touched
//@property (nonatomic, retain) UIColor *sectionIndexTrackingBackgroundColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR; // the background color of the section index while it is being touched
//
//@property (nonatomic) UITableViewCellSeparatorStyle separatorStyle; // default is UITableViewCellSeparatorStyleSingleLine
//@property (nonatomic, retain) UIColor              *separatorColor UI_APPEARANCE_SELECTOR; // default is the standard separator gray
//@property (nonatomic, copy) UIVisualEffect               *separatorEffect NS_AVAILABLE_IOS(8_0) UI_APPEARANCE_SELECTOR; // effect to apply to table separators
//
//@property (nonatomic, retain) UIView *tableHeaderView;                           // accessory view for above row content. default is nil. not to be confused with section header
//@property (nonatomic, retain) UIView *tableFooterView;                           // accessory view below content. default is nil. not to be confused with section footer
//
//- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;  // Used by the delegate to acquire an already allocated cell, in lieu of allocating a new one.
//- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0); // newer dequeue method guarantees a cell is returned and resized properly, assuming identifier is registered
//- (id)dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0);  // like dequeueReusableCellWithIdentifier:, but for headers/footers

// -----------------------------------------------------------------------------------

+ (id) createWithFrame:(CGRect)frame
                 style:(UITableViewStyle)style
           componentId:(NSString *)componentId;
+ (id) createWithStyle:(UITableViewStyle)style componentId:(NSString *)componentId;

// -----------------------------------------------------------------------------------

- (void) setTableData:(NSArray *)tableData;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRTableView : UITableView <IRComponentInfoProtocol, IRAutoLayoutSubComponentsProtocol, UITableViewExport, IRTableViewExport, UIScrollViewExport, IRScrollViewExport, UIViewExport, IRViewExport>

@property (nonatomic, strong) IRTableViewObserver *observer;

@end