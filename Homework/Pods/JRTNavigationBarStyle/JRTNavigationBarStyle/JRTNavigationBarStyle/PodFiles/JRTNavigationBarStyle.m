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

#import "JRTNavigationBarStyle.h"

@implementation UINavigationBar (Style)

- (void)clearStyle
{
    self.backgroundColor = [UIColor clearColor];
    self.barTintColor    = [UIColor clearColor];
    self.tintColor       = [[UIApplication sharedApplication] delegate].window.tintColor;
    self.shadowImage     = [UIImage new];
    self.translucent     = YES;
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}


- (void)setStyleWithBackgorundColor: (UIColor *)backgroundColor titleFont:(UIFont *)titlefont textColor: (UIColor *)textColor removeLowerShadow:(BOOL)removeShadow
{
    [self clearStyle];
    [self setBackgroundImage:[self imageWithColor:backgroundColor] forBarMetrics:UIBarMetricsDefault];
    self.tintColor                      = textColor;
    self.titleTextAttributes            = @{
                                            NSForegroundColorAttributeName : textColor,
                                            NSFontAttributeName : titlefont
                                            };
    if (removeShadow) self.shadowImage  = [UIImage new];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect             = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context    = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image          = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end