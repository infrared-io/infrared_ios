//
//  IRImageViewDescriptor.m
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRImageViewDescriptor.h"
#import "IRImageViewBuilder.h"
#import "IRUtil.h"
#import "IRImageView.h"

@implementation IRImageViewDescriptor

+ (NSString *) componentName
{
    return typeImageViewKEY;
}
+ (Class) componentClass
{
    return [IRImageView class];
}

+ (Class) builderClass
{
    return [IRImageViewBuilder class];
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSDictionary *dictionary;

        // image
        string = aDictionary[NSStringFromSelector(@selector(image))];
        self.image = string;

        // highlightedImage
        string = aDictionary[NSStringFromSelector(@selector(highlightedImage))];
        self.highlightedImage = string;

        // highlighted
        number = aDictionary[NSStringFromSelector(@selector(highlighted))];
        if (number) {
            self.highlighted = [number boolValue];
        } else {
            self.highlighted = NO;
        }

        // imageCapInsets
        dictionary = aDictionary[NSStringFromSelector(@selector(imageCapInsets))];
        self.imageCapInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];

        // highlightedImageCapInsets
        dictionary = aDictionary[NSStringFromSelector(@selector(highlightedImageCapInsets))];
        self.highlightedImageCapInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];

        // preserveAspectRatio
        number = aDictionary[NSStringFromSelector(@selector(preserveAspectRatio))];
        if (number) {
            self.preserveAspectRatio = [number boolValue];
        } else {
            self.preserveAspectRatio = NO;
        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    if (self.image && [IRUtil isLocalFile:self.image] == NO) {
        [imagePaths addObject:self.image];
    }
    if (self.highlightedImage && [IRUtil isLocalFile:self.highlightedImage] == NO) {
        [imagePaths addObject:self.highlightedImage];
    }
}


@end
