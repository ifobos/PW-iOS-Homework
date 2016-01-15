//
//  PWItemModel.m
//  Homework
//
//  Created by Juan Garcia on 1/14/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "PWItemModel.h"

@implementation PWItemModel


+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"description": @"about"
                                                       }];
}

+ (BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (void)itemListWithSuccess:(void (^)(id data))success
                    failure:(void (^)(NSError * error))failure
{
    [self getPath:@"feed.json"
           params:@{}
          success:^(id data)
    {
        NSError *error  = nil;
        NSArray *items  = [PWItemModel arrayOfModelsFromDictionaries:data error:&error];
        if (error)
        {
            NSLog(@"Error: %@", error);
        }
        success(items);
    }
          failure:^(NSError *error)
    {
        failure(error);
    }];
}

@end
