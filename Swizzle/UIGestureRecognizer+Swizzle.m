//
//  UIGestureReconizer+Swizzle.m
//  Swizzle
//
//  Created by Akshat Singhal on 30/03/15.
//  Copyright (c) 2015 New ventures. All rights reserved.
//

#import "UIGestureRecognizer+Swizzle.h"

@implementation UIGestureRecognizer(Swizzle)

+ (void)load {
    [Swizzle exchangeImplementation:@"initWithTarget:action:" InClass:[self class]];
}

- (UIGestureRecognizer *)swizzled_initWithTarget:(id)target action:(SEL)action {
    UIGestureRecognizer *response = [self swizzled_initWithTarget:target action:action];
    [response addTarget:self action:@selector(interceptTouch:)];
    return response;
}



- (void)interceptTouch:(UIGestureRecognizer *)gestureRecogniser {
    CGPoint location = [gestureRecogniser locationInView:gestureRecogniser.view];
    UIView *touchedView = [Swizzle viewTappedInsideView:gestureRecogniser.view AtPoint:location];
    if ([touchedView respondsToSelector:@selector(text)]) {
        [[[UIAlertView alloc] initWithTitle:@"TOUCH EVENT"
                                    message:[touchedView performSelector:@selector(text)]
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil] show];
    }
}


@end
