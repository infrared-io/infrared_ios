//
// Created by Uros Milivojevic on 9/14/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewAndControlDescriptor.h"


@interface IRRefreshControlDescriptor : IRViewAndControlDescriptor

#if TARGET_OS_IPHONE
//@property (nonatomic, retain) UIColor *tintColor;
//@property (nonatomic, retain) NSAttributedString *attributedTitle UI_APPEARANCE_SELECTOR;
#endif

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

@end