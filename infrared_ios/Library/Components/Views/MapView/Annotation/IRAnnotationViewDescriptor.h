//
// Created by Uros Milivojevic on 1/12/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseDescriptor.h"

@class IRPinAnnotationViewDescriptor;
@class IRCalloutAnnotationViewDescriptor;


@interface IRAnnotationViewDescriptor : IRBaseDescriptor

@property (nonatomic, strong) IRPinAnnotationViewDescriptor *pinAnnotationViewDescriptor;

@property (nonatomic, strong) IRCalloutAnnotationViewDescriptor *calloutAnnotationViewDescriptor;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor;

@end