//
// Created by Uros Milivojevic on 12/4/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "IRView.h"
#import "UIScrollViewExport.h"

@protocol IRScrollViewExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRScrollView : UIScrollView <IRComponentInfoProtocol, UIScrollViewExport, IRScrollViewExport, UIViewExport, IRViewExport>

@end