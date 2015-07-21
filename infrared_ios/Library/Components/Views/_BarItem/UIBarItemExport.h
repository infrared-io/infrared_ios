//
// Created by Uros Milivojevic on 7/20/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSExport;

@protocol UIBarItemExport <JSExport>

@property(nonatomic,getter=isEnabled) BOOL         enabled;      // default is YES
@property(nonatomic,copy)             NSString    *title;        // default is nil
@property(nonatomic,retain)           UIImage     *image;        // default is nil
@property(nonatomic,retain)           UIImage     *landscapeImagePhone NS_AVAILABLE_IOS(5_0); // default is nil
@property(nonatomic)                  UIEdgeInsets imageInsets;  // default is UIEdgeInsetsZero
@property(nonatomic)                  UIEdgeInsets landscapeImagePhoneInsets NS_AVAILABLE_IOS(5_0);  // default is UIEdgeInsetsZero. These insets apply only when the landscapeImagePhone property is set.
@property(nonatomic)                  NSInteger    tag;          // default is 0

/* You may specify the font, text color, and shadow properties for the title in the text attributes dictionary, using the keys found in NSAttributedString.h.
 */
- (void)setTitleTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
- (NSDictionary *)titleTextAttributesForState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

@end