//
// Created by Uros Milivojevic on 3/26/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"


@interface IRActionSheet : UIActionSheet <IRComponentInfoProtocol>

@property (nonatomic, strong) NSString *action;
@property (nonatomic, strong) id data;

@end