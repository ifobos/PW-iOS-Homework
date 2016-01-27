//
//  PWItemModel.h
//  Homework
//
//  Created by Juan Garcia on 1/14/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "PWModel.h"

@interface PWItemModel : PWModel

@property (nonatomic, strong) NSString *about;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *locationline1;
@property (nonatomic, strong) NSString *locationline2;

- (void)itemListWithSuccess:(void (^)(id data))success
                    failure:(void (^)(NSError * error))failure;
- (void)refreshItemListWithSuccess:(void (^)(id data))success;

@end
