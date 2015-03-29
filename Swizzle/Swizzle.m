//
//  Swizzle.m
//  Demo Application
//
//  Created by Akshat Singhal on 29/03/15.
//  Copyright (c) 2015 New ventures. All rights reserved.
//

#import "Swizzle.h"

#define SWIZZLE_FUNCTION_PREFIX @"swizzled"

@implementation Swizzle

static NSString *token;

+ (void)initializeWithToken:(NSString *)tokenString {
    token = [NSString stringWithString:tokenString];
    NSLog(@"TOKEN %@", token);
    
}

+ (void)exchangeImplementation:(NSString *)originalSelectorName InClass:(id)className{
    NSString *swizzledSelectorName = [NSString stringWithFormat:@"%@_%@", SWIZZLE_FUNCTION_PREFIX, originalSelectorName];
    static dispatch_once_t once_token;
    dispatch_once(&once_token,  ^{
        SEL originalSelector = NSSelectorFromString(originalSelectorName);
        SEL swizzledSelector = NSSelectorFromString(swizzledSelectorName);
        Method originalMethod = class_getInstanceMethod(className, originalSelector);
        Method extendedMethod = class_getInstanceMethod(className, swizzledSelector);
        method_exchangeImplementations(originalMethod, extendedMethod);
    });
}

+ (UIView *)viewTappedInsideView:(UIView *)view AtPoint:(CGPoint)touchLocation {
    UIView *tappedView = nil;
    for (UIView *subView in [view subviews]) {
        if (CGRectContainsPoint(subView.frame, touchLocation)) {
            tappedView = [Swizzle
                          viewTappedInsideView:subView
                          AtPoint:[subView convertPoint:touchLocation fromView:view]];
            break;
        }
    }
    if (tappedView == nil)
        tappedView = view;
    return tappedView;
}

@end
