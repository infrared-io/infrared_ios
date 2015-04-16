//
// Created by Uros Milivojevic on 10/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRLayoutConstraintDescriptor.h"

@class IRLayoutConstraintMetricsDescriptor;


@interface IRLayoutConstraintWithVFDescriptor : IRLayoutConstraintDescriptor

/*
    NSArray *constraint_POS = [NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-leftMargin-[redView]-viewSpacing-[yellowView]"
                               options:NSLayoutFormatAlignAllTop
                               metrics:metrics
                               views:viewsDictionary];
 */

@property (nonatomic, strong) NSString *visualFormat;
@property (nonatomic) NSLayoutFormatOptions options;
@property (nonatomic, strong) IRLayoutConstraintMetricsDescriptor *metrics;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

@end