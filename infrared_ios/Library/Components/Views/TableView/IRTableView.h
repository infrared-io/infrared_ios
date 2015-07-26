//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRScrollView.h"
#import "IRAutoLayoutSubComponentsProtocol.h"
#import "UITableViewExport.h"

@class IRTableViewObserver;


@protocol IRTableViewExport <JSExport>

+ (id) createWithFrame:(CGRect)frame
                 style:(UITableViewStyle)style
           componentId:(NSString *)componentId;
+ (id) createWithStyle:(UITableViewStyle)style componentId:(NSString *)componentId;

// -----------------------------------------------------------------------------------

- (void) setTableData:(NSArray *)tableData;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRTableView : UITableView <IRComponentInfoProtocol, IRAutoLayoutSubComponentsProtocol, UITableViewExport, IRTableViewExport, UIScrollViewExport, IRScrollViewExport, UIViewExport, IRViewExport>

@property (nonatomic, strong) IRTableViewObserver *observer;

@end