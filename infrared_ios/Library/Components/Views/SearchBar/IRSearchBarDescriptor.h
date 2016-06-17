//
// Created by Uros Milivojevic on 12/12/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewDescriptor.h"


@interface IRSearchBarDescriptor : IRViewDescriptor

#if TARGET_OS_IPHONE
@property(nonatomic)        UIBarStyle              barStyle;              // default is UIBarStyleDefault (blue)
#endif
@property(nonatomic,copy)   NSString               *text;                  // current/starting search text
@property(nonatomic,copy)   NSString               *prompt;                // default is nil
@property(nonatomic,copy)   NSString               *placeholder;           // default is nil
@property(nonatomic)        BOOL                    showsBookmarkButton;   // default is NO
@property(nonatomic)        BOOL                    showsCancelButton;     // default is NO
@property(nonatomic)        BOOL                    showsSearchResultsButton /*NS_AVAILABLE_IOS(3_2)*/; // default is NO
@property(nonatomic/*, getter=isSearchResultsButtonSelected*/) BOOL searchResultsButtonSelected /*NS_AVAILABLE_IOS(3_2)*/; // default is NO

#if TARGET_OS_IPHONE
/*
 The behavior of tintColor for bars has changed on iOS 7.0. It no longer affects the bar's background
 and behaves as described for the tintColor property added to UIView.
 To tint the bar's background, please use -barTintColor.
 */
@property(nonatomic,retain) UIColor *barTintColor NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;  // default is nil

@property (nonatomic) UISearchBarStyle searchBarStyle NS_AVAILABLE_IOS(7_0);
#endif

/*
 New behavior on iOS 7.
 Default is YES.
 You may force an opaque background by setting the property to NO.
 If the search bar has a custom background image, the default is inferred
 from the alpha values of the image—YES if it has any pixel with alpha < 1.0
 If you send setTranslucent:YES to a bar with an opaque custom background image
 it will apply a system opacity less than 1.0 to the image.
 If you send setTranslucent:NO to a bar with a translucent custom background image
 it will provide an opaque background for the image using the bar's barTintColor if defined, or black
 for UIBarStyleBlack or white for UIBarStyleDefault if barTintColor is nil.
 */
@property(nonatomic,assign/*,getter=isTranslucent*/) BOOL translucent /*NS_AVAILABLE_IOS(3_0)*/; // Default is NO on iOS 6 and earlier. Always YES if barStyle is set to UIBarStyleBlackTranslucent

@property(nonatomic,copy) NSArray   *scopeButtonTitles        /*NS_AVAILABLE_IOS(3_0)*/; // array of NSStrings. no scope bar shown unless 2 or more items
@property(nonatomic)      NSInteger  selectedScopeButtonIndex /*NS_AVAILABLE_IOS(3_0)*/; // index into array of scope button titles. default is 0. ignored if out of range
@property(nonatomic)      BOOL       showsScopeBar            /*NS_AVAILABLE_IOS(3_0)*/; // default is NO. if YES, shows the scope bar. call sizeToFit: to update frame

/* Allow placement of an input accessory view to the keyboard for the search bar
 */
@property (nonatomic, readwrite, retain) IRViewDescriptor *inputAccessoryView;

// 1pt wide images and resizable images will be scaled or tiled according to the resizable area, otherwise the image will be tiled
@property(nonatomic,retain) NSString *backgroundImage /*NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR*/;
@property(nonatomic,retain) NSString *scopeBarBackgroundImage /*NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR*/;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor;

@end