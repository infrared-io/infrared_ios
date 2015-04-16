//
// Created by Uros Milivojevic on 12/15/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IRTableViewObserver : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *tableDataArray;

@end