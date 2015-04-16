//
// Created by Uros Milivojevic on 1/12/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRBaseAnnotation.h"
#import "IRMapViewDescriptor.h"


@implementation IRBaseAnnotation

@synthesize annotationData;

- (instancetype) initWithData:(NSDictionary *)annotationData
{
    self = [super init];
    if (self) {
        self.annotationData = annotationData;
        coordinate = kCLLocationCoordinate2DInvalid;
    }
    return self;
}

- (CLLocationCoordinate2D) coordinate
{
    if (CLLocationCoordinate2DIsValid(coordinate) == NO) {
        NSDictionary *anCoordinateDictionary = self.annotationData[coordinateKEY];
        CLLocationCoordinate2D aCoordinate = [IRMapViewDescriptor CLLocationCoordinate2DFromDictionary:anCoordinateDictionary];
        coordinate = aCoordinate;
    }
    return coordinate;
}

- (NSString *) title
{
    return self.annotationData[titleKEY];
}

- (NSString *) subtitle
{
    return self.annotationData[subtitleKEY];
}


@end