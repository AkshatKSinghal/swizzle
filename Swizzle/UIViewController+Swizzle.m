//
//  UIViewController+Logging.m
//  Demo Application
//
//  Created by Akshat Singhal on 29/03/15.
//  Copyright (c) 2015 New ventures. All rights reserved.
//

#import "UIViewController+Swizzle.h"


@implementation UIViewController(Swizzle)


+ (void)load {
    [Swizzle exchangeImplementation:@"viewDidLoad" InClass:[self class]];
}
- (void) swizzled_viewDidLoad {
    if (![self isKindOfClass:[UIAlertController class]]) {
        [self.view addGestureRecognizer:[self tapGesture]];
        [self.view setUserInteractionEnabled:YES];
    }
    [self swizzled_viewDidLoad];
}


- (UITapGestureRecognizer *)tapGesture {
    return [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
}


- (void)viewTapped:(UITapGestureRecognizer *)gestureRecogniser {
    CGPoint location = [gestureRecogniser locationInView:gestureRecogniser.view];
    UIView *touchedView = [Swizzle viewTappedInsideView:self.view AtPoint:location];
    if ([touchedView respondsToSelector:@selector(text)]) {
        [[[UIAlertView alloc] initWithTitle:@"TOUCH EVENT"
                                    message:[touchedView performSelector:@selector(text)]
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil] show];
    }
}


@end
