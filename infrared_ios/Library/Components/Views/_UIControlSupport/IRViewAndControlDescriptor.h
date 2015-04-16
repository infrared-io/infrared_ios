//
//  IRViewAndControlDescriptor.h
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRViewDescriptor.h"
#import "UIControlIRExtension.h"

@interface IRViewAndControlDescriptor : IRViewDescriptor <UIControlIRExtension>

/*
 UIControlContentHorizontalAlignmentCenter = 0, UIControlContentHorizontalAlignmentLeft, UIControlContentHorizontalAlignmentRight, UIControlContentHorizontalAlignmentFill
 */
@property(nonatomic) UIControlContentHorizontalAlignment contentHorizontalAlignment;
/*
 UIControlContentVerticalAlignmentCenter = 0, UIControlContentVerticalAlignmentTop, UIControlContentVerticalAlignmentBottom, UIControlContentVerticalAlignmentFill
 */
@property(nonatomic) UIControlContentVerticalAlignment contentVerticalAlignment;

@property(nonatomic, getter=isSelected) BOOL selected;
@property(nonatomic, getter=isEnabled) BOOL enabled;
@property(nonatomic, getter=isHighlighted) BOOL highlighted;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

@end
