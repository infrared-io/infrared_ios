//
// Created by Uros Milivojevic on 10/26/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRTableViewHeaderOrFooterDescriptor.h"
#import "IRView.h"
#import "IRViewBuilder.h"
#import "IRTableViewHeaderOrFooter.h"


@implementation IRTableViewHeaderOrFooterDescriptor

+ (NSString *) componentName
{
    return typeTableViewHeaderOrFooterKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRTableViewHeaderOrFooter class];
}

+ (Class) builderClass
{
    return [IRViewBuilder class];
}
#endif

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;

        // dynamicAutolayoutRowHeight
        number = aDictionary[NSStringFromSelector(@selector(dynamicAutolayoutHeight))];
        if (number) {
            self.dynamicAutolayoutHeight = [number boolValue];
        } else {
            self.dynamicAutolayoutHeight = NO;
        }

        // dynamicAutolayoutRowHeightMinimum
        number = aDictionary[NSStringFromSelector(@selector(dynamicAutolayoutHeightMinimum))];
        if (number) {
            self.dynamicAutolayoutHeightMinimum = [number floatValue];
        } else {
            self.dynamicAutolayoutHeightMinimum = CGFLOAT_UNDEFINED;
        }
    }
    return self;
}
@end