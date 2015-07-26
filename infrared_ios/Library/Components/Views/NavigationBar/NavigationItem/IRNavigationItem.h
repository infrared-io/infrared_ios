//
// Created by Uros Milivojevic on 12/12/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "IRComponentInfoProtocol.h"
#import "UINavigationItemExport.h"


@protocol IRNavigationItemExport <JSExport>

+ (id) createWithComponentId:(NSString *)componentId;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRNavigationItem : UINavigationItem <IRComponentInfoProtocol, UINavigationItemExport, IRNavigationItemExport>

@end