//
//  ABDismissDetailTransition.m
//  Jeremy Footage
//
//  Created by HoodsDream on 10/13/14.
//  Copyright (c) 2014 Asteroid Blues. All rights reserved.
//

#import "ABDismissDetailTransition.h"

@implementation ABDismissDetailTransition

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *detail = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        detail.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [detail.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
