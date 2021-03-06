//
// Created by Uros Milivojevic on 6/25/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRTabBarItemDescriptor.h"
#import "IRUtil.h"


@implementation IRTabBarItemDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super init];
    if (self) {
        NSString *string;
        NSDictionary *dictionary;

        // screenId
        string = aDictionary[NSStringFromSelector(@selector(screenId))];
        self.screenId = string;

        // title
        string = aDictionary[NSStringFromSelector(@selector(title))];
        self.title = string;

        // image
        string = aDictionary[NSStringFromSelector(@selector(image))];
        self.image = string;

        // data
        dictionary = aDictionary[NSStringFromSelector(@selector(data))];
        self.data = dictionary;
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor
{
    if ([self.image length] > 0 && [IRUtil isFileForDownload:self.image appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.image];
    }
}

@end