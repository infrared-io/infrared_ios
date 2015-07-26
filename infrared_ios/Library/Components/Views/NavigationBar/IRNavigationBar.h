//
// Created by Uros Milivojevic on 12/12/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRView.h"
#import "UINavigationBarExport.h"


@protocol IRNavigationBarExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRNavigationBar : UINavigationBar <IRComponentInfoProtocol, UINavigationBarExport, IRNavigationBarExport, UIViewExport, IRViewExport>

@end