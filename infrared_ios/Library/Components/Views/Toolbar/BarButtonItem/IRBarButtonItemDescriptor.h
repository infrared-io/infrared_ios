//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBarItemDescriptor.h"

@class IRViewDescriptor;


@interface IRBarButtonItemDescriptor : IRBarItemDescriptor

@property(nonatomic)         UIBarButtonSystemItem  identifier;
@property(nonatomic)         UIBarButtonItemStyle   style;            // default is UIBarButtonItemStylePlain
@property(nonatomic)         CGFloat                width;            // default is 0.0
@property(nonatomic,copy)    NSSet                 *possibleTitles;   // default is nil
@property(nonatomic,retain)  IRViewDescriptor      *customView;       // default is nil

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *actions;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end