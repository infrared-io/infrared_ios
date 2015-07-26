//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRView.h"
#import "UITableViewCellExport.h"

@protocol IRTableViewCellExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRTableViewCell : UITableViewCell <IRComponentInfoProtocol, UITableViewCellExport, IRTableViewCellExport, UIViewExport, IRViewExport>

@end