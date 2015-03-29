//
//  UIResponder+Swizzle.m
//  Demo Application
//
//  Created by Akshat Singhal on 29/03/15.
//  Copyright (c) 2015 New ventures. All rights reserved.
//

#import "UIResponder+Swizzle.h"
#import "Swizzle.h"
#import "objc/runtime.h"

@implementation UIResponder(Swizzle)

+ (void)load {
    static dispatch_once_t once_token;
    dispatch_once(&once_token,  ^{
        [Swizzle initializeWithToken:@"1234"];
    });
}




@end
