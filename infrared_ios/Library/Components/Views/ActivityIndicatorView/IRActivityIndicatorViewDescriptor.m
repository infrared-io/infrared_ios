//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRActivityIndicatorViewDescriptor.h"
#import "IRUtil.h"
#if TARGET_OS_IPHONE
#import "IRActivityIndicatorViewBuilder.h"
#import "IRActivityIndicatorView.h"
#endif


@implementation IRActivityIndicatorViewDescriptor

+ (NSString *) componentName
{
    return typeActivityIndicatorViewKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRActivityIndicatorView class];
}

+ (Class) builderClass
{
    return [IRActivityIndicatorViewBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UIActivityIndicatorView class], @protocol(UIActivityIndicatorViewExport));
}
#endif

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;

#if TARGET_OS_IPHONE
        // activityIndicatorViewStyle
        string = aDictionary[NSStringFromSelector(@selector(activityIndicatorViewStyle))];
        self.activityIndicatorViewStyle = [IRBaseDescriptor activityIndicatorViewStyleFromString:string];
#endif

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

#if TARGET_OS_IPHONE
        // color
        string = aDictionary[NSStringFromSelector(@selector(color))];
        self.color = [IRUtil transformHexColorToUIColor:string];
#endif
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor
{

}

@end