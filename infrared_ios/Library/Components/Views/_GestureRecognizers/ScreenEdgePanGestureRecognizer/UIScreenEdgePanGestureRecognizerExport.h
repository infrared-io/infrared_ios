//
// Created by Uros Milivojevic on 7/26/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSExport;

@protocol UIScreenEdgePanGestureRecognizerExport <JSExport>

@property (readwrite, nonatomic, assign) UIRectEdge edges; //< The edges on which this gesture recognizes, relative to the current interface orientation

@end