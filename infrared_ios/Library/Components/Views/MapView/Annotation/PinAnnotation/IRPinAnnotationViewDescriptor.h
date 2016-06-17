//
// Created by Uros Milivojevic on 1/12/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "IRBaseAnnotationViewDescriptor.h"


@interface IRPinAnnotationViewDescriptor : IRBaseAnnotationViewDescriptor

@property (nonatomic) MKPinAnnotationColor pinColor;

@property (nonatomic) BOOL animatesDrop;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:appDescriptor;

@end