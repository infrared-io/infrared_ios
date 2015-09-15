//
// Created by Uros Milivojevic on 9/14/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRRefreshControlDescriptor.h"
#import "IRRefreshControlBuilder.h"
#import "IRRefreshControl.h"
#import "IRUtil.h"


@implementation IRRefreshControlDescriptor

+ (NSString *) componentName
{
    return typeRefreshControlKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRRefreshControl class];
}

+ (Class) builderClass
{
    return [IRRefreshControlBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UIRefreshControl class], @protocol(UIRefreshControlExport));
}
#endif

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
//        NSString *string;
//#if TARGET_OS_IPHONE
//        UIColor *color;
//#endif
//
//#if TARGET_OS_IPHONE
//        // tintColor
//        string = aDictionary[NSStringFromSelector(@selector(tintColor))];
//        color = [IRUtil transformHexColorToUIColor:string];
//        if (color) {
//            self.tintColor = color;
//        }
//#endif
    }
    return self;
}

@end