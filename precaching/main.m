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
        [IRPrecache precacheInfraredAppFromPath:@"https://dl.dropboxusercontent.com/u/133728/ExampleApp1/ir_app.json"];
//        [IRPrecache precacheInfraredAppFromPath:@"http://solarviews.com/raw/earth/bluemarblewest.jpg"];
//        [IRPrecache precacheInfraredAppFromPath:@"https://www.dropbox.com/s/tedmgms1h6qo1g3/DSCF4010.JPG?dl=1"];
    }
    return 0;
}
