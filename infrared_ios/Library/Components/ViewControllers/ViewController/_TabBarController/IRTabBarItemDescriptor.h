//
// Created by Uros Milivojevic on 6/25/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IRTabBarItemDescriptor : NSObject

@property(nonatomic, strong) NSString *screenId;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSDictionary *data;

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end