//
//  PWMasterCollectionViewCell.h
//  Homework
//
//  Created by Juan Garcia on 1/13/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PWMasterCollectionViewCell : UICollectionViewCell
- (void)setBackgroundImageWithURL:(NSURL *)url;
- (void)setDate:(NSString *)date;
- (void)setTitle:(NSString *)title;
- (void)setSubTitle:(NSString *)subTitle;
- (void)setDescription:(NSString *)description;
@end
