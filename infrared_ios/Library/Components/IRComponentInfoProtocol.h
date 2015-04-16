//
// Created by Uros Milivojevic on 8/30/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IRBaseDescriptor;

@protocol IRComponentInfoProtocol <NSObject>

@property(nonatomic, strong) id componentInfo;
@property(nonatomic, strong) IRBaseDescriptor *descriptor;

@end