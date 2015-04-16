//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRProgressViewDescriptor.h"
#import "IRProgressViewBuilder.h"
#import "IRUtil.h"
#import "IRProgressView.h"


@implementation IRProgressViewDescriptor

+ (NSString *) componentName
{
    return typeProgressViewKEY;
}
+ (Class) componentClass
{
    return [IRProgressView class];
}

+ (Class) builderClass
{
    return [IRProgressViewBuilder class];
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;

        // progressViewStyle
        string = aDictionary[NSStringFromSelector(@selector(progressViewStyle))];
        self.progressViewStyle = [IRBaseDescriptor progressViewStyleFromString:string];

        // progress
        number = aDictionary[NSStringFromSelector(@selector(progress))];
        if (number) {
            self.progress = [number floatValue];
        } else {
            self.progress = 0;
        }

        // progressTintColor
        string = aDictionary[NSStringFromSelector(@selector(progressTintColor))];
        self.progressTintColor = [IRUtil transformHexColorToUIColor:string];

        // trackTintColor
        string = aDictionary[NSStringFromSelector(@selector(trackTintColor))];
        self.trackTintColor = [IRUtil transformHexColorToUIColor:string];

        // progressImage
        string = aDictionary[NSStringFromSelector(@selector(progressImage))];
        self.progressImage = string;

        // trackImage
        string = aDictionary[NSStringFromSelector(@selector(trackImage))];
        self.trackImage = string;
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    if (self.progressImage && [IRUtil isLocalFile:self.progressImage] == NO) {
        [imagePaths addObject:self.progressImage];
    }
    if (self.trackImage && [IRUtil isLocalFile:self.trackImage] == NO) {
        [imagePaths addObject:self.trackImage];
    }
}

@end