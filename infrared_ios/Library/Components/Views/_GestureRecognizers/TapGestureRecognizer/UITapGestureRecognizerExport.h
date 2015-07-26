//
// Created by Uros Milivojevic on 7/26/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSExport;

@protocol UITapGestureRecognizerExport <JSExport>

@property (nonatomic) NSUInteger  numberOfTapsRequired;       // Default is 1. The number of taps required to match
@property (nonatomic) NSUInteger  numberOfTouchesRequired;    // Default is 1. The number of fingers required to match

@end