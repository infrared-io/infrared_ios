//
//  IRGestureRecognizerDescriptor.m
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRGestureRecognizerDescriptor.h"
#import "IRTapGestureRecognizerDescriptor.h"
#import "IRSwipeGestureRecognizerDescriptor.h"
#import "IRPinchGestureRecognizerDescriptor.h"

@implementation IRGestureRecognizerDescriptor

+ (IRGestureRecognizerDescriptor *) newGestureRecognizerDescriptorWithDictionary:(NSDictionary *)sourceDictionary
{
    IRGestureRecognizerDescriptor *descriptor = nil;
    GestureRecognizerDescriptorType type = [IRGestureRecognizerDescriptor gestureRecognizerDescriptorTypeForString:
                                                                            sourceDictionary[gestureRecognizerTypeKEY]];
    switch (type) {
        case GestureRecognizerDescriptorTypeTap:
            descriptor = [[IRTapGestureRecognizerDescriptor alloc] initDescriptorWithDictionary:sourceDictionary];
            break;
        case GestureRecognizerDescriptorTypeSwipe:
            descriptor = [[IRSwipeGestureRecognizerDescriptor alloc] initDescriptorWithDictionary:sourceDictionary];
            break;
        case GestureRecognizerDescriptorTypePinch:
            descriptor = [[IRPinchGestureRecognizerDescriptor alloc] initDescriptorWithDictionary:sourceDictionary];
            break;
        case GestureRecognizerDescriptorTypeNone:break;
    }
    return descriptor;
}

+ (GestureRecognizerDescriptorType) gestureRecognizerDescriptorTypeForString:(NSString *)descriptorTypeString
{
    GestureRecognizerDescriptorType descriptorType;
    if ([descriptorTypeString isEqualToString:gestureRecognizerTypeTapKEY]) {
        descriptorType = GestureRecognizerDescriptorTypeTap;
    } else if ([descriptorTypeString isEqualToString:gestureRecognizerTypeSwipeKEY]) {
        descriptorType = GestureRecognizerDescriptorTypeSwipe;
    } else if ([descriptorTypeString isEqualToString:gestureRecognizerTypePinchKEY]) {
        descriptorType = GestureRecognizerDescriptorTypePinch;
    } else {
        descriptorType = GestureRecognizerDescriptorTypeNone;
    }
    return descriptorType;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (UISwipeGestureRecognizerDirection) swipeGestureRecognizerDirectionForString:(NSString *)string
{
    UISwipeGestureRecognizerDirection swipeGestureRecognizerDirection;
    if ([@"UISwipeGestureRecognizerDirectionRight" isEqualToString:string]) {
        swipeGestureRecognizerDirection = UISwipeGestureRecognizerDirectionRight;
    } else if ([@"UISwipeGestureRecognizerDirectionLeft" isEqualToString:string]) {
        swipeGestureRecognizerDirection = UISwipeGestureRecognizerDirectionLeft;
    }  else if ([@"UISwipeGestureRecognizerDirectionUp" isEqualToString:string]) {
        swipeGestureRecognizerDirection = UISwipeGestureRecognizerDirectionUp;
    }   else if ([@"UISwipeGestureRecognizerDirectionDown" isEqualToString:string]) {
        swipeGestureRecognizerDirection = UISwipeGestureRecognizerDirectionDown;
    } else {
        swipeGestureRecognizerDirection = UISwipeGestureRecognizerDirectionLeft;
    }
    return swipeGestureRecognizerDirection;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSString *string;

        // requireGestureRecognizerToFail
        string = aDictionary[NSStringFromSelector(@selector(requireGestureRecognizerToFail))];
        self.requireGestureRecognizerToFail = string;

        // gestureActions
        string = aDictionary[NSStringFromSelector(@selector(gestureActions))];
        self.gestureActions = string;
    }
    return self;
}

@end
