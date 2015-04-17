//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewDescriptor.h"


@interface IRPickerViewDescriptor : IRViewDescriptor

@property(nonatomic)        BOOL                       showsSelectionIndicator;   // default is NO

// --------------------------------------------------------------------------------------------------------------------

@property (nonatomic, strong) NSString *selectRowAction;

@property (nonatomic, strong) NSArray *pickerData;

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end