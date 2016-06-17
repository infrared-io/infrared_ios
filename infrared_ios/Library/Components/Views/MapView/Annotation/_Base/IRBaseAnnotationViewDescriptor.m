//
// Created by Uros Milivojevic on 1/12/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRBaseAnnotationViewDescriptor.h"


@implementation IRBaseAnnotationViewDescriptor

- (NSDictionary *) viewDefaults
{
    NSDictionary *dictionary = [super viewDefaults];
    NSMutableDictionary *defaults = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [defaults setValuesForKeysWithDictionary:@{
      @"enabled" : @(YES),
      @"highlighted" : @(NO),
      @"selected" : @(NO),
      @"canShowCallout" : @(YES),
      @"draggable" : @(NO),
    }];
    return defaults;
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSDictionary *dictionary;
        NSArray *array;

        // image
        string = aDictionary[NSStringFromSelector(@selector(image))];
        self.image = string;

        // centerOffset
        dictionary = aDictionary[NSStringFromSelector(@selector(centerOffset))];
        self.centerOffset = [IRBaseDescriptor pointFromDictionary:dictionary];

        // calloutOffset
        dictionary = aDictionary[NSStringFromSelector(@selector(calloutOffset))];
        self.calloutOffset = [IRBaseDescriptor pointFromDictionary:dictionary];

        // enabled
        number = aDictionary[NSStringFromSelector(@selector(enabled))];
        if (number) {
            self.enabled = [number boolValue];
        } else {
            self.enabled = [[self viewDefaults][NSStringFromSelector(@selector(enabled))] boolValue];
        }

        // highlighted
        number = aDictionary[NSStringFromSelector(@selector(highlighted))];
        if (number) {
            self.highlighted = [number boolValue];
        } else {
            self.highlighted = [[self viewDefaults][NSStringFromSelector(@selector(highlighted))] boolValue];
        }

        // selected
        number = aDictionary[NSStringFromSelector(@selector(selected))];
        if (number) {
            self.selected = [number boolValue];
        } else {
            self.selected = [[self viewDefaults][NSStringFromSelector(@selector(selected))] boolValue];
        }

        // canShowCallout
        number = aDictionary[NSStringFromSelector(@selector(canShowCallout))];
        if (number) {
            self.canShowCallout = [number boolValue];
        } else {
            self.canShowCallout = [[self viewDefaults][NSStringFromSelector(@selector(canShowCallout))] boolValue];
        }

        // leftCalloutAccessoryView
        dictionary = aDictionary[NSStringFromSelector(@selector(leftCalloutAccessoryView))];
        self.leftCalloutAccessoryView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // rightCalloutAccessoryView
        dictionary = aDictionary[NSStringFromSelector(@selector(rightCalloutAccessoryView))];
        self.rightCalloutAccessoryView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // draggable
        number = aDictionary[NSStringFromSelector(@selector(draggable))];
        if (number) {
            self.draggable = [number boolValue];
        } else {
            self.draggable = [[self viewDefaults][NSStringFromSelector(@selector(draggable))] boolValue];
        }

        // selectAnnotationAction
        string = aDictionary[NSStringFromSelector(@selector(selectAnnotationAction))];
        self.selectAnnotationAction = string;

        // deselectAnnotationAction
        string = aDictionary[NSStringFromSelector(@selector(deselectAnnotationAction))];
        self.deselectAnnotationAction = string;
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor
{
    [self.leftCalloutAccessoryView extendImagePathsArray:imagePaths appDescriptor:appDescriptor];
    [self.rightCalloutAccessoryView extendImagePathsArray:imagePaths appDescriptor:appDescriptor];
}

@end