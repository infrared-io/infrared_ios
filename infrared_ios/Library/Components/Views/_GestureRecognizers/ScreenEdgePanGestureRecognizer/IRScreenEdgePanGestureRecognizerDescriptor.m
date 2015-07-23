//
// Created by Uros Milivojevic on 6/18/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRScreenEdgePanGestureRecognizerDescriptor.h"


@implementation IRScreenEdgePanGestureRecognizerDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSString *string;

#if TARGET_OS_IPHONE
        // edges
        string = aDictionary[NSStringFromSelector(@selector(edges))];
        self.edges = [IRBaseDescriptor rectEdgeForString:string];
#endif
    }
    return self;
}
@end