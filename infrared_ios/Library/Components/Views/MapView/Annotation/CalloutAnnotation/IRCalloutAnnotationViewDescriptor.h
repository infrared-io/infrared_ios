//
// Created by Uros Milivojevic on 1/12/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseDescriptor.h"
#import "IRBaseAnnotationViewDescriptor.h"

@class IRViewDescriptor;


@interface IRCalloutAnnotationViewDescriptor : IRBaseAnnotationViewDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end