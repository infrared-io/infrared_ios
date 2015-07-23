//
// Created by Uros Milivojevic on 1/12/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRCalloutAnnotationViewDescriptor.h"
#import "IRViewDescriptor.h"
#if TARGET_OS_IPHONE
#import <MapKit/MapKit.h>
#import "IRCalloutAnnotationViewBuilder.h"
#import "IRCalloutAnnotationView.h"
#endif


@implementation IRCalloutAnnotationViewDescriptor

+ (NSString *) componentName
{
    return typeCalloutAnnotationViewKEY;
}
#if TARGET_OS_IPHONE
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
#endif

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