//
// Created by Uros Milivojevic on 7/26/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSExport;

@protocol UISwipeGestureRecognizerExport <JSExport>

@property(nonatomic) NSUInteger                        numberOfTouchesRequired; // default is 1. the number of fingers that must swipe
@property(nonatomic) UISwipeGestureRecognizerDirection direction;               // default is UISwipeGestureRecognizerDirectionRight. the desired direction of the swipe. multiple directions may be specified if they will result in the same behavior (for example, UITableView swipe delete)

@end