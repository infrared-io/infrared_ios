//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRView.h"
#import "IRControlExportProtocol.h"
#import "UIControlIRExtension.h"
#import "UISwitchExport.h"


@protocol IRSwitchExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRSwitch : UISwitch <IRComponentInfoProtocol, UISwitchExport, IRSwitchExport, IRControlExportProtocol, UIControlIRExtensionExport, UIViewExport, IRViewExport>



@end