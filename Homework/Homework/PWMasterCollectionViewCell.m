//
//  PWMasterCollectionViewCell.m
//  Homework
//
//  Created by Juan Garcia on 1/13/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "PWMasterCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PWMasterCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation PWMasterCollectionViewCell

- (void)setBackgroundImageWithURL:(NSURL *)url
{
    [self.backgroundImageView sd_setImageWithURL:url];
}

- (void)setDate:(NSString *)date
{
    self.dateLabel.text = date;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setSubTitle:(NSString *)subTitle
{
    self.subTitleLabel.text = subTitle;
}

- (void)setDescription:(NSString *)description
{
    self.descriptionLabel.text = description;
}

@end
