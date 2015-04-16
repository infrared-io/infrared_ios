//
// Created by Uros Milivojevic on 1/5/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IRView;

@interface IRKeyboardAutoResizeData : NSObject

@property (nonatomic, strong) IRView *view;
@property (nonatomic, strong) NSLayoutConstraint *constraint;
@property (nonatomic) UIEdgeInsets scrollViewOriginalEdgeInsets;
@property (nonatomic) CGFloat constraintOriginalConstant;

@end