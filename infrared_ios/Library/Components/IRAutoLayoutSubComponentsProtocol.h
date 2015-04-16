//
// Created by Uros Milivojevic on 12/19/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IRAutoLayoutSubComponentsProtocol <NSObject>

- (NSArray *) subComponentsArray;

@property (nonatomic, strong) NSNumber *translatesAutoresizingMaskIntoConstraintsValue;

@end