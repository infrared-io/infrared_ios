//
// Created by Uros Milivojevic on 10/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRLayoutConstraintDescriptor.h"

@interface IRLayoutConstraintICSPriorityDescriptor : IRLayoutConstraintDescriptor

/*
   [button setContentCompressionResistancePriority:500
                                           forAxis:UILayoutConstraintAxisHorizontal];

   [button setContentHuggingPriority:500
                             forAxis:UILayoutConstraintAxisHorizontal];
 */

#if TARGET_OS_IPHONE
@property (nonatomic) LayoutConstraintICSType contentRelationType;
@property (nonatomic) UILayoutConstraintAxis forAxis;
#endif

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

@end