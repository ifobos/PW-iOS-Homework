//Copyright (c) 2015 Juan Carlos Garcia Alfaro. All rights reserved.
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

#import "JRTActivityIndicator.h"
#import "JRTActivityIndicatorView.h"

#define ShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = NO


@interface JRTActivityIndicator ()
@property (nonatomic, strong) UIView<JRTActivityIndicatorViewProtocol> * activityIndicatorview;
@end

CGFloat const kActivityIndicatorAnimationDuration = 0.35;

@implementation JRTActivityIndicator

#pragma mark - Getters

- (NSString *)ViewNibName
{
    return @"JRTActivityIndicatorView";
}

- (UIView<JRTActivityIndicatorViewProtocol> *)activityIndicatorview
{
    if (!_activityIndicatorview)
    {
        UINib *nib = [UINib nibWithNibName:[self ViewNibName] bundle:nil];
        _activityIndicatorview = [[nib instantiateWithOwner:self options:nil] firstObject];
    }
    return _activityIndicatorview;
}

#pragma mark - Public
- (void)show
{
    [self showAnimated:YES];
}

- (void)showAnimated:(BOOL)animated
{
    [self showInView:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:animated network:YES message:nil];
}

- (void)showAnimated:(BOOL)animated message:(NSString *)message
{
    [self showInView:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:animated network:YES message:message];
}


- (void)showInView:(UIView *)view animated:(BOOL)animated network:(BOOL)network message:(NSString *)message
{
    self.activityIndicatorview.frame = view.bounds;
    [view addSubview:self.activityIndicatorview];

    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicatorview
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:view
                                                                           attribute:NSLayoutAttributeWidth
                                                                          multiplier:1.0
                                                                            constant:0.0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicatorview
                                                                           attribute:NSLayoutAttributeHeight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:view
                                                                           attribute:NSLayoutAttributeHeight
                                                                          multiplier:1.0
                                                                            constant:0.0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicatorview
                                                                           attribute:NSLayoutAttributeCenterX
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:view
                                                                           attribute:NSLayoutAttributeCenterX
                                                                          multiplier:1.0
                                                                            constant:0.0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicatorview
                                                                           attribute:NSLayoutAttributeCenterY
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:view
                                                                           attribute:NSLayoutAttributeCenterY
                                                                          multiplier:1.0
                                                                            constant:0.0]];
    if (animated)
    {
        self.activityIndicatorview.alpha = 0;
        [UIView animateWithDuration:kActivityIndicatorAnimationDuration
                         animations:^
                                    {
                                        self.activityIndicatorview.alpha = 1;
                                    }];
    }
    else
    {
        self.activityIndicatorview.alpha = 1;
    }
    if (network) [self ShowNetworkActivity];
    if (message) [self.activityIndicatorview setMessage:message];
}

- (void)hideAnimated:(BOOL)animated network:(BOOL)network
{
    if (animated)
    {
        self.activityIndicatorview.alpha = 1;
        [UIView animateWithDuration:kActivityIndicatorAnimationDuration
                         animations:^
                                    {
                                        self.activityIndicatorview.alpha = 0;
                                    }
                         completion:^(BOOL finished)
                                    {
                                        [self.activityIndicatorview removeFromSuperview];
                                        self.activityIndicatorview.alpha = 1;
                                    }];
    }
    else
    {
        [self.activityIndicatorview removeFromSuperview];
        self.activityIndicatorview.alpha = 1;
    }
    if (network) [self HideNetworkActivity];
}

- (void)hideAnimated:(BOOL)animated;
{
    [self hideAnimated:animated network:YES];
}

- (void)hide
{
    [self hideAnimated:YES];
}

- (void)ShowNetworkActivity
{
    ShowNetworkActivityIndicator();
}

- (void)HideNetworkActivity
{
    HideNetworkActivityIndicator();
}

@end
