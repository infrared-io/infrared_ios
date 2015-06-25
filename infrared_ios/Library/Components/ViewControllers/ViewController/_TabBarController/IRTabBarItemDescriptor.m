//
// Created by Uros Milivojevic on 6/25/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRTabBarItemDescriptor.h"


@implementation IRTabBarItemDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super init];
    if (self) {
        NSString *string;

        // screenId
        string = aDictionary[NSStringFromSelector(@selector(screenId))];
        self.screenId = string;

        // title
        string = aDictionary[NSStringFromSelector(@selector(title))];
        self.title = string;

        // image
        string = aDictionary[NSStringFromSelector(@selector(image))];
        self.image = string;
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    if (self.image && self.image.length > 0) {
        [imagePaths addObject:self.image];
    }
}

@end