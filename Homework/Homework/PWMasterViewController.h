//
//  PWMasterViewController.h
//  Homework
//
//  Created by Juan Garcia on 1/13/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWItemController.h"

@interface PWMasterViewController : UICollectionViewController <PWViewController>

@property (nonatomic, strong) PWItemController *itemController;

@end
