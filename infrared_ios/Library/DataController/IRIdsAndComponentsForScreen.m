//
// Created by Uros Milivojevic on 10/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRIdsAndComponentsForScreen.h"
#import "IRScreenDescriptor.h"
#import "IRComponentInfoProtocol.h"
#import "IRBaseDescriptor.h"


@implementation IRIdsAndComponentsForScreen

- (id) init
{
    self = [super init];
    if (self) {
        self.viewIdAndComponents = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void) registerComponent:(id <IRComponentInfoProtocol>)component
{
    self.viewIdAndComponents[component.descriptor.componentId] = component;
}

@end