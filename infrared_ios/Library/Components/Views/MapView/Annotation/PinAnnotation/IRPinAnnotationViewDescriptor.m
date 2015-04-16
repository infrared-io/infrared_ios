//
// Created by Uros Milivojevic on 1/12/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRViewDescriptor.h"
#import "IRPinAnnotationViewDescriptor.h"
#import "IRPinAnnotationViewBuilder.h"
#import "IRMapViewDescriptor.h"


@implementation IRPinAnnotationViewDescriptor

+ (NSString *) componentName
{
    return typePinAnnotationViewKEY;
}

+ (Class) builderClass
{
    return [IRPinAnnotationViewBuilder class];
}

- (NSDictionary *) viewDefaults
{
    NSDictionary *dictionary = [super viewDefaults];
    NSMutableDictionary *defaults = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [defaults setValuesForKeysWithDictionary:@{
      @"animatesDrop" : @(NO),
    }];
    return defaults;
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;

        // pinColor
        string = aDictionary[NSStringFromSelector(@selector(pinColor))];
        self.pinColor = [IRMapViewDescriptor pinColorFromString:string];

        // animatesDrop
        number = aDictionary[NSStringFromSelector(@selector(animatesDrop))];
        if (number) {
            self.animatesDrop = [number boolValue];
        } else {
            self.animatesDrop = [[self viewDefaults][NSStringFromSelector(@selector(animatesDrop))] boolValue];
        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{

}

@end