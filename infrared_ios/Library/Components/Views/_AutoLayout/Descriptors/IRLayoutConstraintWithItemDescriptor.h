//
// Created by Uros Milivojevic on 10/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRLayoutConstraintDescriptor.h"


@interface IRLayoutConstraintWithItemDescriptor : IRLayoutConstraintDescriptor

/*
 [self.view addConstraint:[NSLayoutConstraint
                           constraintWithItem:self.yellowView
                           attribute:NSLayoutAttributeWidth
                           relatedBy:NSLayoutRelationEqual
                           toItem:self.redView
                           attribute:NSLayoutAttributeWidth
                           multiplier:0.5
                           constant:0.0]];
 */

@property (nonatomic, strong) NSString *withItem;
@property (nonatomic) NSLayoutAttribute withItemAttribute;
@property (nonatomic) NSLayoutRelation relatedBy;
@property (nonatomic, strong) NSString *toItem;
@property (nonatomic) NSLayoutAttribute toItemAttribute;
@property (nonatomic, strong) NSNumber *multiplier;
@property (nonatomic, strong) NSNumber *constant;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

@end