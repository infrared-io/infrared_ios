//
// Created by Uros Milivojevic on 1/12/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRAnnotationViewDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRPinAnnotationViewDescriptor.h"
#import "IRCalloutAnnotationViewDescriptor.h"


@implementation IRAnnotationViewDescriptor

+ (NSString *) componentName
{
    return typeAnnotationViewKEY;
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSDictionary *dictionary;

        // pinAnnotationViewDescriptor
        dictionary = aDictionary[pinKEY];
        self.pinAnnotationViewDescriptor = [[IRPinAnnotationViewDescriptor alloc] initDescriptorWithDictionary:dictionary];

        // calloutAnnotationViewDescriptor
        dictionary = aDictionary[calloutKEY];
        self.calloutAnnotationViewDescriptor = [[IRCalloutAnnotationViewDescriptor alloc] initDescriptorWithDictionary:dictionary];
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor
{
    [self.pinAnnotationViewDescriptor extendImagePathsArray:imagePaths appDescriptor:appDescriptor];
    [self.calloutAnnotationViewDescriptor extendImagePathsArray:imagePaths appDescriptor:appDescriptor];
}

@end