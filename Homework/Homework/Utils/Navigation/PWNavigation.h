//
//  NavigationCore.h
//  Homework
//
//  Created by Juan Garcia on 1/13/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

@import UIKit;

@interface PWNavigation : NSObject

+ (instancetype)sharedIntance;
- (id)rootViewController;
- (void)navigationBarClearStyle;
- (void)navigationBarWhiteStyle;
- (void)navigationBarWhiteStyleWithAlpha:(CGFloat)alpha;
- (UIBarButtonItem *)backBarButtonWithTarget:(id)target action:(SEL)action;
- (UIBarButtonItem *)shareBarButtonWithTarget:(id)target action:(SEL)action;

@end
