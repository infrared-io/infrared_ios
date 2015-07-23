//
//  IRImageViewDescriptor.h
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewDescriptor.h"

@interface IRImageViewDescriptor : IRViewDescriptor

@property(nonatomic, strong) /*UIImage*/ NSString *image;
@property(nonatomic, strong) /*UIImage*/ NSString *highlightedImage;

@property(nonatomic/*, getter=isHighlighted*/) BOOL highlighted;

#if TARGET_OS_IPHONE
@property(nonatomic) UIEdgeInsets imageCapInsets;
@property(nonatomic) UIEdgeInsets highlightedImageCapInsets;
#endif

// TODO: implement this
//@property(nonatomic) BOOL preserveAspectRatio;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end
