//
//  PWItemModel.h
//  Homework
//
//  Created by Juan Garcia on 1/14/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "PWModel.h"

@interface PWItemModel : PWModel
@property (nonatomic, strong) NSString *desciption;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *locationline1;
@property (nonatomic, strong) NSString *locationline2;

//{
//    "description": "Rebel Forces spotted on Hoth. Quell their rebellion for the Empire.",
//    "title": "Stop Rebel Forces",
//    "timestamp": "2015-06-18T17:02:02.614Z",
//    "image": "https://raw.githubusercontent.com/phunware/services-interview-resources/master/images/Battle_of_Hoth.jpg",
//    "date": "2015-06-18T23:30:00.000Z",
//    "locationline1": "Hoth",
//    "locationline2": "Anoat System"
//}

- (void)itemListWithSuccess:(void (^)(id data))success
                    failure:(void (^)(NSError * error))failure;

@end
