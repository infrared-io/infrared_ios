//
// Created by Uros Milivojevic on 1/11/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRCalloutAnnotation.h"


@implementation IRCalloutAnnotation

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.coordinate = kCLLocationCoordinate2DInvalid;
    }
    return self;
}

- (instancetype) initWithAnnotation:(IRBaseAnnotation *)annotation
{
    self = [super initWithData:annotation.annotationData];
    if (self) {

    }
    return self;
}


@end