//
//  Swizzle.h
//  Demo Application
//
//  Created by Akshat Singhal on 29/03/15.
//  Copyright (c) 2015 New ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "objc/runtime.h"

@interface Swizzle : NSObject

+ (void)initializeWithToken:(NSString *)tokenString;
+ (void)exchangeImplementation:(NSString *)originalSelectorName InClass:(id)className;
+ (UIView *)viewTappedInsideView:(UIView *)view AtPoint:(CGPoint)touchLocation;
@end
