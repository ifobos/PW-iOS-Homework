//
//  PWItemController.m
//  Homework
//
//  Created by Juan Garcia on 1/13/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "PWItemController.h"
#import "PWDetailViewController.h"
#import "PWItemModel.h"
#import "JRTActivityIndicator.h"

@interface PWItemController()
@property (nonatomic, strong)   NSArray     *items;
@property (nonatomic)           NSInteger   selectedIndex;
@end

@implementation PWItemController

#pragma mark - Getters

- (NSArray *)items
{
    if (!_items)
    {
        _items = [NSArray new];
        [self fetchItems];
    }
    return _items;
}

- (void)fetchItems
{
    JRTActivityIndicator *activityIndicator = [JRTActivityIndicator new];
    [activityIndicator showAnimated:YES];
    [[PWItemModel new] itemListWithSuccess:^(id data)
    {
        self.items = data;
        [self.viewController loadData];
        [activityIndicator removeAnimated:YES];
    }
                                   failure:^(NSError *error)
    {
        NSLog(@"Error: %@", error);
        [activityIndicator removeAnimated:YES];
    }];
}

#pragma mark - Master Items

- (NSInteger) numberOfItems
{
    return [self.items count];
}

- (NSURL *)imageURLOfItemAtIndex:(NSInteger)index
{
    PWItemModel *targetItem = [self.items objectAtIndex:index];
    return [NSURL URLWithString:[targetItem.image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
}

- (NSString *)dateOfItemAtIndex:(NSInteger)index
{
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (NSString *)titleOfItemAtIndex:(NSInteger)index
{
    PWItemModel *targetItem = [self.items objectAtIndex:index];
    return targetItem.title;
}

- (NSString *)subTitleOfItemAtIndex:(NSInteger)index
{
    PWItemModel *targetItem = [self.items objectAtIndex:index];
    return [NSString stringWithFormat:@"%@\n%@",targetItem.locationline1, targetItem.locationline2];
}

- (NSString *)descriptionOfItemAtIndex:(NSInteger)index
{
    PWItemModel *targetItem = [self.items objectAtIndex:index];
    return targetItem.about;
}

#pragma mark - Navigation

- (void)goToDetailForItemAtIndex:(NSInteger)index
{
    self.selectedIndex                              = index;
    PWDetailViewController *detailViewController    = [PWDetailViewController new];
    detailViewController.itemController             = self;
    [self.viewController.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - Detail Item

- (NSURL *)imageURLOfSelectedItem
{
    return [self imageURLOfItemAtIndex:self.selectedIndex];
}

- (NSString *)dateOfSelectedItem
{
    return [self dateOfItemAtIndex:self.selectedIndex];
}

- (NSString *)titleOfSelectedItem
{
    return [self titleOfItemAtIndex:self.selectedIndex];
}

- (NSString *)subTitleOfSelectedItem
{
    return [self subTitleOfItemAtIndex:self.selectedIndex];
}

- (NSString *)descriptionOfSelectedItem
{
    return [self descriptionOfItemAtIndex:self.selectedIndex];
}

@end