//
//  NavigationCore.m
//  Homework
//
//  Created by Juan Garcia on 1/13/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "PWNavigation.h"
#import "JRTNavigationBarStyle.h"

NSString * const kInitialViewController = @"PWMasterViewController";

@interface PWNavigation ()
@property (nonatomic, strong) UINavigationController *mainNavigationController;
@end

@implementation PWNavigation

+ (instancetype)sharedIntance
{
    static PWNavigation *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [PWNavigation new];
    });
    return instance;
}


- (id)rootViewController
{
    return self.mainNavigationController;
}

- (UINavigationController *)mainNavigationController
{
    if (!_mainNavigationController)
    {
        _mainNavigationController   = [[UINavigationController alloc] initWithRootViewController:[NSClassFromString(kInitialViewController) new]];
        _mainNavigationController.interactivePopGestureRecognizer.enabled  = YES;
        _mainNavigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    return _mainNavigationController;
}

- (void)navigationBarClearStyle
{
    [self.mainNavigationController.navigationBar clearStyle];
}

- (void)navigationBarWhiteStyle
{
    [self navigationBarWhiteStyleWithAlpha:1];
}

- (void)navigationBarWhiteStyleWithAlpha:(CGFloat)alpha
{
    [self.mainNavigationController.navigationBar setStyleWithBackgorundColor:[UIColor colorWithWhite:1 alpha:(alpha * 0.97)]
                                                                   titleFont:[UIFont systemFontOfSize:18 weight:UIFontWeightBold]
                                                                   textColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:alpha]
                                                           removeLowerShadow:YES];
}

- (UIBarButtonItem *)backBarButtonWithTarget:(id)target action:(SEL)action
{
    return [self barButtonWithImage:[UIImage imageNamed:@"backIcon"]
                             target:target
                             action:action];
}

- (UIBarButtonItem *)shareBarButtonWithTarget:(id)target action:(SEL)action
{
    return [self barButtonWithImage:[UIImage imageNamed:@"shareIcon"]
                             target:target
                             action:action];
}

- (UIBarButtonItem *)barButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIBarButtonItem *shareBarButton  = [[UIBarButtonItem alloc] initWithImage:image
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:target
                                                                       action:action];
    shareBarButton.tintColor         = [UIColor darkGrayColor];
    return shareBarButton;

}


@end
