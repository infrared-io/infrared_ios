//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRPageControlDescriptor.h"
#import "IRPageControlBuilder.h"
#import "IRUtil.h"
#import "IRPageControl.h"


@implementation IRPageControlDescriptor

+ (NSString *) componentName
{
    return typePageControlKEY;
}
+ (Class) componentClass
{
    return [IRPageControl class];
}

+ (Class) builderClass
{
    return [IRPageControlBuilder class];
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSDictionary *dictionary;

        // numberOfPages
        number = aDictionary[NSStringFromSelector(@selector(numberOfPages))];
        if (number) {
            self.numberOfPages = [number integerValue];
        } else {
            self.numberOfPages = 0;
        }

        // currentPage
        number = aDictionary[NSStringFromSelector(@selector(currentPage))];
        if (number) {
            self.currentPage = [number integerValue];
        } else {
            self.currentPage = 0;
        }

        // hidesForSinglePage
        number = aDictionary[NSStringFromSelector(@selector(hidesForSinglePage))];
        if (number) {
            self.hidesForSinglePage = [number boolValue];
        } else {
            self.hidesForSinglePage = NO;
        }

        // defersCurrentPageDisplay
        number = aDictionary[NSStringFromSelector(@selector(defersCurrentPageDisplay))];
        if (number) {
            self.defersCurrentPageDisplay = [number boolValue];
        } else {
            self.defersCurrentPageDisplay = NO;
        }

        // pageIndicatorTintColor
        string = aDictionary[NSStringFromSelector(@selector(pageIndicatorTintColor))];
        self.pageIndicatorTintColor = [IRUtil transformHexColorToUIColor:string];

        // currentPageIndicatorTintColor
        string = aDictionary[NSStringFromSelector(@selector(currentPageIndicatorTintColor))];
        self.currentPageIndicatorTintColor = [IRUtil transformHexColorToUIColor:string];
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{

}

@end