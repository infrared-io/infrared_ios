//
//  IRPrecache.h
//  infrared_ios
//
//  Created by Uros Milivojevic on 7/22/15.
//  Copyright (c) 2015 infrared.io. All rights reserved.
//

@interface IRPrecache : NSObject

+ (void) precacheInfraredAppFromPath:(NSString *)path
       withExtraComponentDescriptors:(NSArray *)descriptorClassedArray;
+ (void) precacheInfraredAppFromPath:(NSString *)path;

@end
