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
#import <JRTActivityIndicator.h>

@interface PWItemController()
@property (nonatomic, strong)   NSArray         *items;
@property (nonatomic)           NSInteger       selectedIndex;
@property (nonatomic, strong)   NSDateFormatter *dateFormatter;
@end

NSString * const kFormatDateModel   = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
NSString * const kFormatDateView    = @"MMM d, yyyy 'at' h:mmaa";

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

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter)
    {
        _dateFormatter = [NSDateFormatter new];
        [_dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [_dateFormatter setAMSymbol:@"am"];
        [_dateFormatter setPMSymbol:@"pm"];
    }
    return _dateFormatter;
}

#pragma mark - Fetch

- (void)fetchItems
{
    JRTActivityIndicator *activityIndicator = [JRTActivityIndicator new];
    [activityIndicator show];
    [[PWItemModel new] itemListWithSuccess:^(id data)
    {
        self.items = data;
        [self.mainViewController loadData];
        [activityIndicator hide];
    }
                                   failure:^(NSError *error)
    {
        NSLog(@"Error: %@", error);
        [activityIndicator hide];
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
    PWItemModel *targetItem = [self.items objectAtIndex:index];
    [self.dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [self.dateFormatter setDateFormat:kFormatDateModel];
    NSDate *date            = [self.dateFormatter dateFromString:targetItem.date];
    [self.dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [self.dateFormatter setDateFormat:kFormatDateView];
    return [self.dateFormatter stringFromDate:date];
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
    [self.mainViewController.navigationController pushViewController:detailViewController animated:YES];
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

#pragma mark - Share

- (void)shareItem:(NSArray *)itemsToShare sender:(id)sender
{
    UIActivityViewController *activity  = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare
                                                                            applicationActivities:nil];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:activity];
        [popOver presentPopoverFromBarButtonItem:sender
                        permittedArrowDirections:UIPopoverArrowDirectionAny
                                        animated:YES];
    }
    else
    {
        [self.mainViewController.navigationController presentViewController:activity
                                                                   animated:YES
                                                                 completion:nil];
    }

}

@end
