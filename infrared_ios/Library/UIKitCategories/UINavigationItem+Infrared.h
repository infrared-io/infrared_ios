//
// Created by Uros Milivojevic on 7/29/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UINavigationItem (Infrared)

//@property(nonatomic,retain) UIBarButtonItem *leftBarButtonItem;
//@property(nonatomic,retain) UIBarButtonItem *rightBarButtonItem;

- (void) setLeftBarButtonItem:(UIBarButtonItem *)barButtonItem;
- (void) setRightBarButtonItem:(UIBarButtonItem *)barButtonItem;

@end