//
// Created by Uros Milivojevic on 1/12/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRCalloutAnnotationViewDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRCalloutAnnotationViewBuilder.h"
#import "IRCalloutAnnotationView.h"
#import <MapKit/MapKit.h>
#import <objc/runtime.h>


@implementation IRCalloutAnnotationViewDescriptor

+ (NSString *) componentName
{
    return typeCalloutAnnotationViewKEY;
}
+ (Class) componentClass
{
    return [IRCalloutAnnotationView class];
}

+ (Class) builderClass
{
    return [IRCalloutAnnotationViewBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([MKAnnotationView class], @protocol(MKAnnotationViewExport));
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