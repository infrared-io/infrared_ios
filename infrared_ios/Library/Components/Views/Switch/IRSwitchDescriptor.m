//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRSwitchDescriptor.h"
#import "IRSwitchBuilder.h"
#import "IRUtil.h"
#import "IRSwitch.h"


@implementation IRSwitchDescriptor

+ (NSString *) componentName
{
    return typeSwitchKEY;
}
+ (Class) componentClass
{
    return [IRSwitch class];
}

+ (Class) builderClass
{
    return [IRSwitchBuilder class];
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;

        // onTintColor
        string = aDictionary[NSStringFromSelector(@selector(onTintColor))];
        self.onTintColor = [IRUtil transformHexColorToUIColor:string];

        // tintColor
        string = aDictionary[NSStringFromSelector(@selector(tintColor))];
        self.tintColor = [IRUtil transformHexColorToUIColor:string];

        // thumbTintColor
        string = aDictionary[NSStringFromSelector(@selector(thumbTintColor))];
        self.thumbTintColor = [IRUtil transformHexColorToUIColor:string];

        // onImage
        string = aDictionary[NSStringFromSelector(@selector(onImage))];
        self.onImage = string;

        // offImage
        string = aDictionary[NSStringFromSelector(@selector(offImage))];
        self.offImage = string;

        // on
        number = aDictionary[NSStringFromSelector(@selector(on))];
        if (number) {
            self.on = [number boolValue];
        } else {
            self.on = NO;
        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    if (self.onImage && [IRUtil isLocalFile:self.onImage] == NO) {
        [imagePaths addObject:self.onImage];
    }
    if (self.offImage && [IRUtil isLocalFile:self.offImage] == NO) {
        [imagePaths addObject:self.offImage];
    }
}

@end