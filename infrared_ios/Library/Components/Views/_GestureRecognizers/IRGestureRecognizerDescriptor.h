//
//  IRGestureRecognizerDescriptor.h
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseDescriptor.h"

typedef enum {
    GestureRecognizerDescriptorTypeNone,
    GestureRecognizerDescriptorTypeTap,
    GestureRecognizerDescriptorTypeSwipe,
    GestureRecognizerDescriptorTypePinch
} GestureRecognizerDescriptorType;

@interface IRGestureRecognizerDescriptor : IRBaseDescriptor

@property (nonatomic, strong) NSString *requireGestureRecognizerToFail;
@property (nonatomic, strong) NSString *gestureActions;

+ (IRGestureRecognizerDescriptor *) newGestureRecognizerDescriptorWithDictionary:(NSDictionary *)sourceDictionary;

+ (UISwipeGestureRecognizerDirection) swipeGestureRecognizerDirectionForString:(NSString *)string;

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

@end
