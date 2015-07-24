//
//  main.m
//  precaching
//
//  Created by Uros Milivojevic on 7/22/15.
//  Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRPrecache.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *appJsonPath = @"https://dl.dropboxusercontent.com/u/133728/ExampleApp1/ir_app.json";
//        NSArray *arguments = [[NSProcessInfo processInfo] arguments];
//        if ([arguments count] > 1) {
//            appJsonPath = arguments[1];
//        }
        [IRPrecache precacheInfraredAppFromPath:appJsonPath];
    }
    return 0;
}
