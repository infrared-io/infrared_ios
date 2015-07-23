//
// Created by Uros Milivojevic on 6/23/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRCollectionReusableViewDescriptor.h"
#if TARGET_OS_IPHONE
#import "IRCollectionReusableView.h"
#import "IRCollectionReusableViewBuilder.h"
#endif


@implementation IRCollectionReusableViewDescriptor

+ (NSString *) componentName
{
    return typeCollectionReusableViewKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRCollectionReusableView class];
}

+ (Class) builderClass
{
    return [IRCollectionReusableViewBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UICollectionReusableView class], @protocol(UICollectionReusableViewExport));
}
#endif

//- (NSDictionary *) viewDefaults
//{
//    NSDictionary *dictionary = [super viewDefaults];
//    NSMutableDictionary *defaults = [NSMutableDictionary dictionaryWithDictionary:dictionary];
//    [defaults setValuesForKeysWithDictionary:@{
//      @"clipsToBounds" : @(YES)
//    }];
//    return defaults;
//}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {

    }
    return self;
}
@end