//
// Created by Uros Milivojevic on 12/6/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRView.h"
#import "IRControlExportProtocol.h"
#import "UIControlIRExtension.h"
#import "UISliderExport.h"


@protocol IRSliderExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRSlider : UISlider <IRComponentInfoProtocol, UISliderExport, IRSliderExport, IRControlExportProtocol, UIControlIRExtensionExport, UIViewExport, IRViewExport>
@end