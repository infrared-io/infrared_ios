//
// Created by Uros Milivojevic on 1/12/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRCalloutAnnotationViewDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRCalloutAnnotationViewBuilder.h"


@implementation IRCalloutAnnotationViewDescriptor

+ (NSString *) componentName
{
    return typeCalloutAnnotationViewKEY;
}

+ (Class) builderClass
{
    return [IRCalloutAnnotationViewBuilder class];
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {

    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{

}

@end