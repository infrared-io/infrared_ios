//
// Created by Uros Milivojevic on 6/25/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRTabBarControllerSubDescriptor.h"
#import "IRTabBarItemDescriptor.h"


@implementation IRTabBarControllerSubDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super init];
    if (self) {
        NSNumber *number;
        NSArray *array;

        // viewControllers
        array = aDictionary[NSStringFromSelector(@selector(viewControllers))];
        if (array) {
            self.viewControllers = [NSMutableArray array];
            for (NSDictionary *dictionary in array) {
                [self.viewControllers addObject:[[IRTabBarItemDescriptor alloc] initDescriptorWithDictionary:dictionary]];
            }
        }

        // selectedIndex
        number = aDictionary[NSStringFromSelector(@selector(selectedIndex))];
        if (number) {
            self.selectedIndex = [number unsignedIntegerValue];
            if (self.selectedIndex >= [self.viewControllers count]) {
                self.selectedIndex = [self.viewControllers count]-1;
            }
        } else {
            self.selectedIndex = 0;
        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    if (self.viewControllers) {
        for (IRTabBarItemDescriptor *descriptor in self.viewControllers) {
            [descriptor extendImagePathsArray:imagePaths];
        }
    }
}

@end