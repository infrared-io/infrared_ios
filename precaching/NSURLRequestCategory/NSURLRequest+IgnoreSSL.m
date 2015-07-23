//
// Created by Uros Milivojevic on 7/23/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "NSURLRequest+IgnoreSSL.h"


@implementation NSURLRequest (IgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host
{
    NSLog(@"allowsAnyHTTPSCertificateForHost");
    return YES;
//    // ignore certificate errors only for this domain
//    if ([host hasSuffix:@"site.com"]) {
//        return YES;
//    } else {
//        return NO;
//    }
}

@end