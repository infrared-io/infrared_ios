//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRActivityIndicatorViewDescriptor.h"
#import "IRActivityIndicatorViewBuilder.h"
#import "IRUtil.h"
#import "IRActivityIndicatorView.h"


@implementation IRActivityIndicatorViewDescriptor

+ (NSString *) componentName
{
    return typeActivityIndicatorViewKEY;
}
+ (Class) componentClass
{
    return [IRActivityIndicatorView class];
}

+ (Class) builderClass
{
    return [IRActivityIndicatorViewBuilder class];
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;

        // activityIndicatorViewStyle
        string = aDictionary[NSStringFromSelector(@selector(activityIndicatorViewStyle))];
        self.activityIndicatorViewStyle = [IRBaseDescriptor activityIndicatorViewStyleFromString:string];

        // hidesWhenStopped
        number = aDictionary[NSStringFromSelector(@selector(hidesWhenStopped))];
        if (number) {
            self.hidesWhenStopped = [number boolValue];
        } else {
            self.hidesWhenStopped = YES;
        }

        // animating
        number = aDictionary[NSStringFromSelector(@selector(animating))];
        if (number) {
            self.animating = [number boolValue];
        } else {
            self.animating = YES;
        }

        // color
        string = aDictionary[NSStringFromSelector(@selector(color))];
        self.color = [IRUtil transformHexColorToUIColor:string];
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{

}

@end