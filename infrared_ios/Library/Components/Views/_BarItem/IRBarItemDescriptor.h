//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseDescriptor.h"


@interface IRBarItemDescriptor : IRBaseDescriptor

@property(nonatomic,getter=isEnabled) BOOL         enabled;      // default is YES
@property(nonatomic,copy)             NSString    *title;        // default is nil
@property(nonatomic,retain)           NSString    *image;        // default is nil
@property(nonatomic,retain)           NSString    *landscapeImagePhone NS_AVAILABLE_IOS(5_0); // default is nil
@property(nonatomic)                  UIEdgeInsets imageInsets;  // default is UIEdgeInsetsZero
@property(nonatomic)                  UIEdgeInsets landscapeImagePhoneInsets NS_AVAILABLE_IOS(5_0);  // default is UIEdgeInsetsZero. These insets apply only when the landscapeImagePhone property is set.
@property(nonatomic)                  NSInteger    tag;          // default is 0

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;


@end