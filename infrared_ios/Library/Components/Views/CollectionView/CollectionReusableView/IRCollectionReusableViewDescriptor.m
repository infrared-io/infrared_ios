//
// Created by Uros Milivojevic on 6/23/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRCollectionReusableViewDescriptor.h"
#import "IRCollectionReusableView.h"
#import "IRCollectionReusableViewBuilder.h"


@implementation IRCollectionReusableViewDescriptor

+ (NSString *) componentName
{
    return typeCollectionReusableViewKEY;
}
+ (Class) componentClass
{
    return [IRCollectionReusableView class];
}

+ (Class) builderClass
{
    return [IRCollectionReusableViewBuilder class];
}

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