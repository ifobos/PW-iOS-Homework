//
//  PWDetailViewController.m
//  Homework
//
//  Created by Juan Garcia on 1/13/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "PWDetailViewController.h"
#import "PWNavigation.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PWDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView    *imageView;
@property (weak, nonatomic) IBOutlet UILabel        *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel        *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel        *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel        *descriptionLabel;
@end

CGFloat  const kMinOffsetY = - 64;

@implementation PWDetailViewController

#pragma mark - View Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUp];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[PWNavigation sharedIntance] navigationBarWhiteStyleWithAlpha:0];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[PWNavigation sharedIntance] navigationBarWhiteStyle];
}

#pragma mark - Setup

- (void)setUp
{
    self.navigationItem.leftBarButtonItem   = [[PWNavigation sharedIntance] backBarButtonWithTarget:self action:@selector(goBack)];
    self.navigationItem.rightBarButtonItem  = [[PWNavigation sharedIntance] shareBarButtonWithTarget:self action:@selector(share)];
    [self loadData];
}

#pragma mark - PWViewController

- (void)loadData
{
    [self.imageView sd_setImageWithURL:[self.itemController imageURLOfSelectedItem]];
    self.title                              = [self.itemController titleOfSelectedItem];
    self.dateLabel.text                     = [self.itemController dateOfSelectedItem];
    self.titleLabel.text                    = [self.itemController titleOfSelectedItem];
    self.subTitleLabel.text                 = [self.itemController subTitleOfSelectedItem];
    self.descriptionLabel.text              = [self.itemController descriptionOfSelectedItem];
    self.tableView.tableFooterView.frame    = [self footerViewFrame];
}

#pragma mark - Helpers

- (CGRect)footerViewFrame
{
    CGFloat labelWidth   = [[UIScreen mainScreen] bounds].size.width - 40;
    CGFloat labelHeight  = [self.descriptionLabel.text boundingRectWithSize:CGSizeMake(labelWidth, 1000)
                                                               options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                            attributes:@{NSFontAttributeName: self.descriptionLabel.font}
                                                               context:nil].size.height;
    return CGRectMake(0, 0, labelWidth + 40, labelHeight + 40);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - Navigation

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Scroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[PWNavigation sharedIntance] navigationBarWhiteStyleWithAlpha: 1 - (scrollView.contentOffset.y / kMinOffsetY)];
}

#pragma mark - Share

- (void)share
{
    NSArray *itemsToShare               = @[
                                            [NSString stringWithFormat:@"%@\n\n%@", self.titleLabel.text, self.descriptionLabel.text],
                                            self.imageView.image
                                            ];
    UIActivityViewController *activity  = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare
                                                                                applicationActivities:nil];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
       UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:activity];
        [popOver presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    else
    {
        [self presentViewController:activity
                           animated:YES
                         completion:nil];
    }
}

@end
