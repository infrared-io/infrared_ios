//
// Created by Uros Milivojevic on 12/12/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewDescriptor.h"


@interface IRNavigationBarDescriptor : IRViewDescriptor

#if TARGET_OS_IPHONE
@property(nonatomic,assign) UIBarStyle barStyle;
#endif

/*
 New behavior on iOS 7.
 Default is YES.
 You may force an opaque background by setting the property to NO.
 If the navigation bar has a custom background image, the default is inferred
 from the alpha values of the image—YES if it has any pixel with alpha < 1.0
 If you send setTranslucent:YES to a bar with an opaque custom background image
 it will apply a system opacity less than 1.0 to the image.
 If you send setTranslucent:NO to a bar with a translucent custom background image
 it will provide an opaque background for the image using the bar's barTintColor if defined, or black
 for UIBarStyleBlack or white for UIBarStyleDefault if barTintColor is nil.
 */
@property(nonatomic,assign/*,getter=isTranslucent*/) BOOL translucent /*NS_AVAILABLE_IOS(3_0)*/; // Default is NO on iOS 6 and earlier. Always YES if barStyle is set to UIBarStyleBlackTranslucent

@property(nonatomic,copy) NSArray *items;

#if TARGET_OS_IPHONE
/*
 The behavior of tintColor for bars has changed on iOS 7.0. It no longer affects the bar's background
 and behaves as described for the tintColor property added to UIView.
 To tint the bar's background, please use -barTintColor.
 */
@property(nonatomic,retain) UIColor *barTintColor NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;  // default is nil
#endif

/* Default is nil. When non-nil, a custom shadow image to show instead of the default shadow image. For a custom shadow to be shown, a custom background image must also be set with -setBackgroundImage:forBarMetrics: (if the default background image is used, the default shadow image will be used).
 */
@property(nonatomic,retain) NSString *shadowImage /*NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR*/;

/* You may specify the font, text color, and shadow properties for the title in the text attributes dictionary, using the keys found in NSAttributedString.h.
 */
@property(nonatomic,copy) NSDictionary *titleTextAttributes /*NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR*/;

/*
 The back indicator image is shown beside the back button.
 The back indicator transition mask image is used as a mask for content during push and pop transitions
 Note: These properties must both be set if you want to customize the back indicator image.
 */
@property(nonatomic,retain) NSString *backIndicatorImage /*NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR*/;
@property(nonatomic,retain) NSString *backIndicatorTransitionMaskImage /*NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR*/;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor;

@end