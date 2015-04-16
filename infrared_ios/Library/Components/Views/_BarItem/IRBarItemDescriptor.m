//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRBarItemDescriptor.h"
#import "IRUtil.h"


@implementation IRBarItemDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;

        // enabled
        number = aDictionary[NSStringFromSelector(@selector(enabled))];
        if (number) {
            self.enabled = [number boolValue];
        } else {
            self.enabled = YES;
        }

        // title
        string = aDictionary[NSStringFromSelector(@selector(title))];
        self.title = string;

        // image
        string = aDictionary[NSStringFromSelector(@selector(image))];
        self.image = string;

        // landscapeImagePhone
        string = aDictionary[NSStringFromSelector(@selector(landscapeImagePhone))];
        self.landscapeImagePhone = string;

        // imageInsets
        string = aDictionary[NSStringFromSelector(@selector(imageInsets))];
        self.imageInsets = [IRBaseDescriptor edgeInsetsFromDictionary:string];

        // landscapeImagePhoneInsets
        string = aDictionary[NSStringFromSelector(@selector(landscapeImagePhoneInsets))];
        self.landscapeImagePhoneInsets = [IRBaseDescriptor edgeInsetsFromDictionary:string];

        // tag
        number = aDictionary[NSStringFromSelector(@selector(tag))];
        self.tag = [number integerValue];
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    if (self.image && [IRUtil isLocalFile:self.image] == NO) {
        [imagePaths addObject:self.image];
    }
    if (self.landscapeImagePhone && [IRUtil isLocalFile:self.landscapeImagePhone] == NO) {
        [imagePaths addObject:self.landscapeImagePhone];
    }
}

@end