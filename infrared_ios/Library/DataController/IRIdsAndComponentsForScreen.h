//
// Created by Uros Milivojevic on 10/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IRScreenDescriptor;
@protocol IRComponentInfoProtocol;
@class IRBaseDescriptor;

@interface IRIdsAndComponentsForScreen : NSObject

@property (nonatomic, strong) NSString *viewControllerAddress;
@property (nonatomic, strong) NSMutableDictionary *viewIdAndComponents;

- (void) registerComponent:(id <IRComponentInfoProtocol>)component;

@end