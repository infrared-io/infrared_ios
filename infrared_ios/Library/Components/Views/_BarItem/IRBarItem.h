//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "UIBarItemExport.h"
#import <JavaScriptCore/JavaScriptCore.h>


@protocol IRBarItemExport <JSExport>

+ (id) create;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRBarItem : UIBarItem <IRComponentInfoProtocol, UIBarItemExport, IRBarItemExport>

@end