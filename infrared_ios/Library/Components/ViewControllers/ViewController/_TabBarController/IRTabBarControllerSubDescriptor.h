//
// Created by Uros Milivojevic on 6/25/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IRTabBarControllerSubDescriptor : NSObject

@property (nonatomic, strong) NSMutableArray *viewControllers;
@property(nonatomic) NSUInteger selectedIndex;

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end