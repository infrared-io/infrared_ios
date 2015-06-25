//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRScreenDescriptor.h"
#import "IRViewDescriptor.h"


@implementation IRScreenDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSDictionary *dictionary;

        // viewControllerDescriptor
        dictionary = aDictionary[controllerKEY];
        self.viewControllerDescriptor = (IRViewControllerDescriptor *) [IRBaseDescriptor newControllerDescriptorWithDictionary:dictionary
                                                                                                              screenDictionary:aDictionary];

        // view
        dictionary = aDictionary[viewKEY];
        self.rootViewDescriptor = [[IRViewDescriptor alloc] initDescriptorWithDictionary:dictionary];
    }
    return self;
}

@end