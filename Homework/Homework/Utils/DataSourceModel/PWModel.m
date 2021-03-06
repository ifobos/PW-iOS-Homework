//
//  PWModel.m
//  Homework
//
//  Created by Juan Garcia on 1/14/16.
//  Copyright © 2016 Applaudo Studios. All rights reserved.
//

#import "PWModel.h"

@implementation PWModel

- (void)headerWithSuccess:(void (^)(NSArray *headers))successHeader
                  failure:(void (^)(NSError *error))failure
{
    successHeader(nil);
}

- (NSString *)API_URL
{
    return @"https://raw.githubusercontent.com/phunware/services-interview-resources/master";
}

- (void)catchFailureOperation:(NSURLSessionTask *)operation
                        error:(NSError *)error
                  requestType:(JRTRequestType)requestType
                         path:(NSString *)path
                       params:(NSDictionary *)params
                      success:(JRTObjectBlok)success
                      failure:(JRTErrorBlock)failure
{
            failure(error);
}

@end
