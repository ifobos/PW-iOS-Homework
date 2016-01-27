//
//  PWItemModel.m
//  Homework
//
//  Created by Juan Garcia on 1/14/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "PWItemModel.h"

NSString * const kCacheItems = @"cacheItems";

@implementation PWItemModel

#pragma mark - JSONModel

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

#pragma mark - Public

- (void)itemListWithSuccess:(void (^)(id data))success
                    failure:(void (^)(NSError * error))failure
{
    [self itemListCacheWithSuccess:success];
    [self itemListRequestWithSuccess:success failure:failure];
}

- (void)refreshItemListWithSuccess:(void (^)(id data))success
{
    [self itemListRequestWithSuccess:success
                             failure:^(NSError *error)
    {
        success(nil);
    }];
}

#pragma mark - Cache

- (void)itemListCacheWithSuccess:(void (^)(id data))success
{
    if ([[NSUserDefaults standardUserDefaults] arrayForKey:kCacheItems])
    {
        NSError *error      = nil;
        NSArray *cacheData  = [[NSUserDefaults standardUserDefaults] arrayForKey:kCacheItems];
        NSArray *cacheItems = [PWItemModel arrayOfModelsFromDictionaries:cacheData error:&error];
        if (error)
        {
            NSLog(@"Error: %@", error);
        }
        success(cacheItems);
    }
}

#pragma mark - Request

- (void)itemListRequestWithSuccess:(void (^)(id data))success
                           failure:(void (^)(NSError * error))failure
{
    [self getPath:@"feed.json"
           params:@{}
          success:^(id data)
     {
         [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCacheItems];
         [[NSUserDefaults standardUserDefaults] synchronize];
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
