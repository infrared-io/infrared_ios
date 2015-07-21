//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "UIBarItemExport.h"
#import <JavaScriptCore/JavaScriptCore.h>


@protocol IRBarItemExport <JSExport>

//@property(nonatomic,getter=isEnabled) BOOL         enabled;      // default is YES
//@property(nonatomic,copy)             NSString    *title;        // default is nil
//@property(nonatomic,retain)           UIImage     *image;        // default is nil
//@property(nonatomic,retain)           UIImage     *landscapeImagePhone NS_AVAILABLE_IOS(5_0); // default is nil
//@property(nonatomic)                  UIEdgeInsets imageInsets;  // default is UIEdgeInsetsZero
//@property(nonatomic)                  UIEdgeInsets landscapeImagePhoneInsets NS_AVAILABLE_IOS(5_0);  // default is UIEdgeInsetsZero. These insets apply only when the landscapeImagePhone property is set.
//@property(nonatomic)                  NSInteger    tag;          // default is 0
//
///* You may specify the font, text color, and shadow properties for the title in the text attributes dictionary, using the keys found in NSAttributedString.h.
// */
//- (void)setTitleTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
//- (NSDictionary *)titleTextAttributesForState:(UIControlState)state NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

// -----------------------------------------------------------------------------------

+ (id) create;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRBarItem : UIBarItem <IRComponentInfoProtocol, UIBarItemExport, IRBarItemExport>

@end