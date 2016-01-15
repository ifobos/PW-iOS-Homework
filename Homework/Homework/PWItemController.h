//
//  PWItemController.h
//  Homework
//
//  Created by Juan Garcia on 1/13/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

@import UIKit;

@protocol PWViewController <NSObject>

- (void)loadData;

@end

@interface PWItemController : NSObject

@property (nonatomic, weak) UIViewController<PWViewController> *viewController;

- (NSInteger) numberOfItems;
- (NSURL *)imageURLOfItemAtIndex:(NSInteger)index;
- (NSString *)dateOfItemAtIndex:(NSInteger)index;
- (NSString *)titleOfItemAtIndex:(NSInteger)index;
- (NSString *)subTitleOfItemAtIndex:(NSInteger)index;
- (NSString *)descriptionOfItemAtIndex:(NSInteger)index;
- (void)goToDetailForItemAtIndex:(NSInteger)index;
- (NSURL *)imageURLOfSelectedItem;
- (NSString *)dateOfSelectedItem;
- (NSString *)titleOfSelectedItem;
- (NSString *)subTitleOfSelectedItem;
- (NSString *)descriptionOfSelectedItem;

@end
