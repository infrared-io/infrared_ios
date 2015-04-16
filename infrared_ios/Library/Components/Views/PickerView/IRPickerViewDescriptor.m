//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRPickerViewDescriptor.h"
#import "IRPickerViewBuilder.h"
#import "IRPickerView.h"


@implementation IRPickerViewDescriptor

+ (NSString *) componentName
{
    return typePickerViewKEY;
}
+ (Class) componentClass
{
    return [IRPickerView class];
}

+ (Class) builderClass
{
    return [IRPickerViewBuilder class];
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;

        // showsSelectionIndicator
        number = aDictionary[NSStringFromSelector(@selector(showsSelectionIndicator))];
        if (number) {
            self.showsSelectionIndicator = [number boolValue];
        } else {
            self.showsSelectionIndicator = NO;
        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{

}

@end