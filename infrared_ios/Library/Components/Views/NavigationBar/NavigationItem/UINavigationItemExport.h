//
// Created by Uros Milivojevic on 7/21/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSExport;

@protocol UINavigationItemExport <JSExport>

@property(nonatomic,copy)   NSString        *title;             // Title when topmost on the stack. default is nil
@property(nonatomic,retain) UIBarButtonItem *backBarButtonItem; // Bar button item to use for the back button in the child navigation item.
@property(nonatomic,retain) UIView          *titleView;         // Custom view to use in lieu of a title. May be sized horizontally. Only used when item is topmost on the stack.

@property(nonatomic,copy)   NSString *prompt;     // Explanatory text to display above the navigation bar buttons.

@property(nonatomic,assign) BOOL hidesBackButton; // If YES, this navigation item will hide the back button when it's on top of the stack.
- (void)setHidesBackButton:(BOOL)hidesBackButton animated:(BOOL)animated;

/* Use these properties to set multiple items in a navigation bar.
The older single properties (leftBarButtonItem and rightBarButtonItem) now refer to
the first item in the respective array of items.

NOTE: You'll achieve the best results if you use either the singular properties or
the plural properties consistently and don't try to mix them.

   leftBarButtonItems are placed in the navigation bar left to right with the first
item in the list at the left outside edge and left aligned.
   rightBarButtonItems are placed right to left with the first item in the list at
the right outside edge and right aligned.
*/
@property(nonatomic,copy) NSArray *leftBarButtonItems NS_AVAILABLE_IOS(5_0);
@property(nonatomic,copy) NSArray *rightBarButtonItems NS_AVAILABLE_IOS(5_0);
- (void)setLeftBarButtonItems:(NSArray *)items animated:(BOOL)animated NS_AVAILABLE_IOS(5_0);
- (void)setRightBarButtonItems:(NSArray *)items animated:(BOOL)animated NS_AVAILABLE_IOS(5_0);

/* By default, the leftItemsSupplementBackButton property is NO. In this case,
the back button is not drawn and the left item or items replace it. If you
would like the left items to appear in addition to the back button (as opposed to instead of it)
set leftItemsSupplementBackButton to YES.
*/
@property(nonatomic) BOOL leftItemsSupplementBackButton NS_AVAILABLE_IOS(5_0);


// Some navigation items want to display a custom left or right item when they're on top of the stack.
// A custom left item replaces the regular back button unless you set leftItemsSupplementBackButton to YES
@property(nonatomic,retain) UIBarButtonItem *leftBarButtonItem;
@property(nonatomic,retain) UIBarButtonItem *rightBarButtonItem;
- (void)setLeftBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated;
- (void)setRightBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated;

@end