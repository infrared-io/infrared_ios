//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewDescriptor.h"


@interface IRActivityIndicatorViewDescriptor : IRViewDescriptor

#if TARGET_OS_IPHONE
@property(nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle; // default is UIActivityIndicatorViewStyleWhite
#endif
@property(nonatomic) BOOL                         hidesWhenStopped;           // default is YES. calls -setHidden when animating gets set to NO
@property(nonatomic) BOOL                         animating;           // default is NO.

#if TARGET_OS_IPHONE
@property (readwrite, nonatomic, retain) UIColor *color NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
#endif

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor;

@end