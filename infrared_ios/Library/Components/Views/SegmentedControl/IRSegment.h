//
// Created by Uros Milivojevic on 12/6/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IRSegment : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic) BOOL enabled;
@property (nonatomic) BOOL selected;
@property (nonatomic) CGSize contentOffset;

@end