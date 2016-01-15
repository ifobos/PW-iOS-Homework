//
//  PWMasterViewController.m
//  Homework
//
//  Created by Juan Garcia on 1/13/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "PWMasterViewController.h"
#import "PWMasterCollectionViewCell.h"

@interface PWMasterViewController ()<UICollectionViewDelegate>
@end

@implementation PWMasterViewController

static NSInteger    const smallScreenColumns    = 1;
static NSInteger    const bigScreenColumns      = 2;
static CGFloat      const cellHeight            = 180;
static CGFloat      const cellSpacing           = 1;
static NSString *   const reuseIdentifier       = @"Cell";

+ (instancetype)new
{
    UICollectionViewFlowLayout *collectionViewFlowLayout    = [UICollectionViewFlowLayout new];
    collectionViewFlowLayout.scrollDirection                = UICollectionViewScrollDirectionVertical;
    collectionViewFlowLayout.sectionInset                   = UIEdgeInsetsMake(cellSpacing, cellSpacing, cellSpacing, cellSpacing);
    collectionViewFlowLayout.minimumLineSpacing             = cellSpacing;
    collectionViewFlowLayout.minimumInteritemSpacing        = cellSpacing;
    return [[self alloc] initWithCollectionViewLayout:collectionViewFlowLayout];
}

#pragma mark Getter

- (PWItemController *)itemController
{
    if (!_itemController)
    {
        _itemController = [PWItemController new];
        _itemController.viewController = self;
    }
    return _itemController;
}

#pragma mark UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"PhunApp",);
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PWMasterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self.collectionView.collectionViewLayout invalidateLayout];
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

#pragma mark <UICollectionViewFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSInteger columns = ([[UIScreen mainScreen] bounds].size.width < 768)? smallScreenColumns : bigScreenColumns;
    return  CGSizeMake((([[UIScreen mainScreen] bounds].size.width - (cellSpacing *(columns+1)))/columns), cellHeight);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.itemController numberOfItems];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PWMasterCollectionViewCell *cell    = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setBackgroundImageWithURL:[self.itemController imageURLOfItemAtIndex:indexPath.row]];
    [cell setDate:[self.itemController dateOfItemAtIndex:indexPath.row]];
    [cell setTitle:[self.itemController titleOfItemAtIndex:indexPath.row]];
    [cell setSubTitle:[self.itemController subTitleOfItemAtIndex:indexPath.row]];
    [cell setDescription:[self.itemController descriptionOfItemAtIndex:indexPath.row]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.itemController goToDetailForItemAtIndex:indexPath.row];
}

#pragma mark - PWViewController

- (void)loadData
{
    [self.collectionView reloadData];
}

@end