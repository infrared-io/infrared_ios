//
// Created by Uros Milivojevic on 12/6/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewAndControlDescriptor.h"


@interface IRSegmentedControlDescriptor : IRViewAndControlDescriptor

@property(nonatomic,getter=isMomentary) BOOL momentary;             // if set, then we don't keep showing selected state after tracking ends. default is NO
@property(nonatomic,strong) NSMutableArray *segmentsArray;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor;

@end