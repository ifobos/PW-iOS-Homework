//Copyright (c) 2015 Juan Carlos Garcia Alfaro. All rights reserved.
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

#import "JRTModelAPI.h"


@interface JRTModelAPI()
@property (nonatomic, strong) AFHTTPSessionManager<Ignore> *manager;
@property (nonatomic, readonly) NSString * keyErrorDescription;
@property (nonatomic, readonly) NSString * keyErrorFailureReason;
@end


@implementation JRTModelAPI

#pragma mark - Implement


- (void)headerWithSuccess:(void (^)(NSArray *headers))successHeader
                  failure:(void (^)(NSError *error))failure
{
    @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                       reason:[NSString stringWithFormat:@"%@, It should be implemented in sub-class. ", NSStringFromSelector(_cmd)]
                                     userInfo:nil];
    
//    ######################################################################################
//                                          Example:
//    ######################################################################################
//
//    NSMutableArray *result      = [NSMutableArray new];
//    ModelUser *currentUser      = [ModelUser currentUser];
//    if (currentUser.userToken && [currentUser.userToken length] > 0)
//        [result addObject:@{
//                            @"key"    : @"Authorization",
//                            @"value"  : currentUser.userToken
//                            }];
//    successHeader(result);
//
//    ######################################################################################
//
//    successHeader(nil);
//
//    ######################################################################################
    
    
}

- (NSString *)API_URL
{
    @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                       reason:[NSString stringWithFormat:@"%@, It should be implemented in sub-class. ", NSStringFromSelector(_cmd)]
                                     userInfo:nil];
    return nil;
}


- (NSString *)keyErrorDescription
{
    @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                       reason:[NSString stringWithFormat:@"(readonly) %@, It should be implemented in sub-class. ", NSStringFromSelector(_cmd)]
                                     userInfo:nil];

    return nil;
}

- (NSString *)keyErrorFailureReason
{
    @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                       reason:[NSString stringWithFormat:@"(readonly) %@, It should be implemented in sub-class. ", NSStringFromSelector(_cmd)]
                                     userInfo:nil];

    return nil;
}

- (void)catchError:(NSError *)error
  requestOperation:(NSURLSessionTask *)operation
       requestType:(JRTRequestType)requestType
              path:(NSString *)path
            params:(NSDictionary *)params
           success:(JRTObjectBlok)success
           failure:(JRTErrorBlock)failure
{
    @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                       reason:[NSString stringWithFormat:@"%@, It should be implemented in sub-class. ", NSStringFromSelector(_cmd)]
                                     userInfo:nil];
    
//    ######################################################################################
//                                          Example:
//    ######################################################################################
//
//    if (error.code == 401)
//    {
//        //Refres Autorization Success
//        [self executeRequestType:requestType
//                        withPath:path
//                          params:params
//                         success:success
//                         failure:failure];
//    }
//    else
//    {
//        failure(error);
//    }
//
//    ######################################################################################
//
//    failure(error);
//
//    ######################################################################################
  
}

#pragma mark - Getters

- (AFHTTPSessionManager *)manager
{
    if (!_manager)
    {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (id)getClass
{
    return self.class;
}


- (void)setHeaderParameters:(NSArray *)headers
       forRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer
      andResponseSerializer:(AFHTTPResponseSerializer *)responseSerializer
{
    if ([headers count] > 0)
    {
        for (int i=0; i<[headers count]; i++)
        {
            NSDictionary *header = (NSDictionary *)[headers objectAtIndex:i];
            [requestSerializer setValue:[header objectForKey:@"value"]
                     forHTTPHeaderField:[header objectForKey:@"key"]];
        }
    }
    self.manager.requestSerializer  = requestSerializer;
    self.manager.responseSerializer = responseSerializer;
//    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];

}

#pragma mark - Request

- (void)executeRequestType:(JRTRequestType)requestType
                  withPath:(NSString *)path
                    params:(NSDictionary *)params
                   success:(JRTObjectBlok)success
                   failure:(JRTErrorBlock)failure
{
    switch (requestType)
    {
        case JRTRequestTypeGet:
            [self getPath:path
                   params:params
                  success:success
                  failure:failure];
            break;
        case JRTRequestTypePost:
            [self postPath:path
                    params:params
                   success:success
                   failure:failure];
            break;
        case JRTRequestTypePostJson:
            [self postJsonForPath:path
                           params:params
                          success:success
                          failure:failure];
            break;
        case JRTRequestTypePut:
            [self putPath:path
                   params:params
                  success:success
                  failure:failure];
            break;
        case JRTRequestTypePutJson:
            [self putJsonForPath:path
                          params:params
                         success:success
                         failure:failure];
            break;
        case JRTRequestTypeDelete:
            [self deletePath:path
                      params:params
                     success:success
                     failure:failure];
            break;
        default:
            break;
    }
}


#pragma mark - GET

- (void)getPath:(NSString *)path
         params:(NSDictionary *)params
        success:(JRTObjectBlok)success
        failure:(JRTErrorBlock)failure
{
    [self headerWithSuccess:^(NSArray *headers)
                            {
                                [self setHeaderParameters:headers
                                     forRequestSerializer:self.manager.requestSerializer
                                    andResponseSerializer:[AFHTTPResponseSerializer serializer]];
                                NSString *encodedPath = [self urlencode:path];
                                [self.manager GET:[NSString stringWithFormat:@"%@/%@", self.API_URL, encodedPath]
                                       parameters:params
                                         progress:^(NSProgress * _Nonnull downloadProgress)
                                {
                                    NSLog(@"Progress: %@", downloadProgress);
                                }
                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                                {
                                    NSError *error;
                                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                                    success(result);
                                }
                                          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                                {
                                    NSLog(@"Error on [GET]: %@", error);
                                    [self catchError:[self errorFromOperation:task]
                                    requestOperation:task
                                         requestType:JRTRequestTypeGet
                                                path:path
                                              params:params
                                             success:success
                                             failure:failure];

                                }];
                            }
                    failure:^(NSError *error)
                            {
                                failure(error);
                            }];
}

#pragma mark - POST

- (void)postPath:(NSString *)path
          params:(NSDictionary *)params
         success:(JRTObjectBlok)success
         failure:(JRTErrorBlock)failure
{
    [self headerWithSuccess:^(NSArray *headers)
                            {
                                NSString *encodedPath = [self urlencode:path];
                                [self setHeaderParameters:headers
                                     forRequestSerializer:self.manager.requestSerializer
                                    andResponseSerializer:[AFHTTPResponseSerializer serializer]];
                                [self.manager POST:[NSString stringWithFormat:@"%@/%@", self.API_URL, encodedPath]
                                        parameters:params
                                          progress:^(NSProgress * _Nonnull uploadProgress)
                                {
                                    NSLog(@"Progress: %@", uploadProgress);
                                }
                                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                                {
                                    success(responseObject);
                                }
                                           failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                                {
                                    NSLog(@"Error on [POST]: %@", error);
                                    [self catchError:[self errorFromOperation:task]
                                    requestOperation:task
                                         requestType:JRTRequestTypePost
                                                path:path
                                              params:params
                                             success:success
                                             failure:failure];

                                }];
                            }
                    failure:^(NSError *error)
                            {
                                failure(error);
                            }];
}

- (void)postJsonForPath:(NSString *)path
                 params:(NSDictionary *)params
                success:(JRTObjectBlok)success
                failure:(JRTErrorBlock)failure
{
    [self headerWithSuccess:^(NSArray *headers)
                            {
                                NSString *encodedPath                       = [self urlencode:path];
                                AFJSONRequestSerializer *requestSerializer  = [AFJSONRequestSerializer serializer];
                                [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                                [self setHeaderParameters:headers
                                     forRequestSerializer:requestSerializer
                                    andResponseSerializer:[AFHTTPResponseSerializer serializer]];
                                [self.manager POST:[NSString stringWithFormat:@"%@/%@", self.API_URL, encodedPath]
                                        parameters:params
                                          progress:^(NSProgress * _Nonnull uploadProgress)
                                {
                                    NSLog(@"Progress: %@", uploadProgress);
                                }
                                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                                {
                                    success(responseObject);
                                }
                                           failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                                {
                                    NSLog(@"Error on [POST]: %@", error);
                                    NSLog(@"JSON Error on [POST]: %@", task.response);
                                    [self catchError:[self errorFromOperation:task]
                                    requestOperation:task
                                         requestType:JRTRequestTypePostJson
                                                path:path
                                              params:params
                                             success:success
                                             failure:failure];
                                }];
                            }
                    failure:^(NSError *error)
                            {
                                failure(error);
                            }];
}


#pragma mark - PUT

- (void)putPath:(NSString *)path
         params:(NSDictionary *)params
        success:(JRTObjectBlok)success
        failure:(JRTErrorBlock)failure
{
    
    [self headerWithSuccess:^(NSArray *headers)
                            {
                                NSString *encodedPath = [self urlencode:path];
                                [self setHeaderParameters:headers
                                     forRequestSerializer:self.manager.requestSerializer
                                    andResponseSerializer:[AFHTTPResponseSerializer serializer]];
                                [self.manager PUT:[NSString stringWithFormat:@"%@/%@", self.API_URL, encodedPath]
                                       parameters:params
                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                                {
                                    success(responseObject);
                                }
                                          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                                {
                                    NSLog(@"Error on [GET]: %@", error);
                                    [self catchError:[self errorFromOperation:task]
                                    requestOperation:task
                                         requestType:JRTRequestTypePut
                                                path:path
                                              params:params
                                             success:success
                                             failure:failure];
                                }];
                                
                            }
                        failure:^(NSError *error)
                            {
                                failure(error);
                            }];
}

- (void)putJsonForPath:(NSString *)path
                params:(NSDictionary *)params
               success:(JRTObjectBlok)success
               failure:(JRTErrorBlock)failure
{
    [self headerWithSuccess:^(NSArray *headers)
                            {
                                NSString *encodedPath = [self urlencode:path];
                                AFJSONRequestSerializer *requestSerializer  = [AFJSONRequestSerializer serializer];
                                [requestSerializer setValue:@"application/json"
                                         forHTTPHeaderField:@"Content-Type"];
                                [self setHeaderParameters:headers
                                     forRequestSerializer:requestSerializer
                                    andResponseSerializer:[AFHTTPResponseSerializer serializer]];
                                [self.manager PUT:[NSString stringWithFormat:@"%@/%@", self.API_URL, encodedPath]
                                       parameters:params
                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                                {
                                    success(responseObject);
                                }
                                          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                                {
                                    NSLog(@"Error on [PUT]: %@", error);
                                    NSLog(@"JSON Error on [PUT]: %@", task.response);
                                    [self catchError:[self errorFromOperation:task]
                                    requestOperation:task
                                         requestType:JRTRequestTypePutJson
                                                path:path
                                              params:params
                                             success:success
                                             failure:failure];
                                }];
                            }
                    failure:^(NSError *error)
                            {
                                failure(error);
                            }];
}

#pragma mark - DELETE

- (void)deletePath:(NSString *)path
            params:(NSDictionary *)params
           success:(JRTObjectBlok)success
           failure:(JRTErrorBlock)failure
{
    [self headerWithSuccess:^(NSArray *headers)
                            {
                                NSString *encodedPath = [self urlencode:path];
                                [self setHeaderParameters:headers
                                     forRequestSerializer:self.manager.requestSerializer
                                    andResponseSerializer:[AFHTTPResponseSerializer serializer]];
                                [self.manager DELETE:[NSString stringWithFormat:@"%@/%@", self.API_URL, encodedPath]
                                          parameters:params
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                                {
                                    success(responseObject);
                                }
                                             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                                {
                                    NSLog(@"Error on [Delete]: %@", error);
                                    [self catchError:[self errorFromOperation:task]
                                    requestOperation:task
                                         requestType:JRTRequestTypeDelete
                                                path:path
                                              params:params
                                             success:success
                                             failure:failure];
                                }];
                            }
                    failure:^(NSError *error)
                            {
                                failure(error);
                            }];
}

#pragma mark - helper

- (NSString *)urlencode:(NSString *)url
{
    NSString* encodedUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return encodedUrl;
}


-(NSError *)errorFromOperation:(NSURLSessionDataTask *)operation
{
    NSDictionary * errorJson = nil;
    NSString *description    = @"Error";
    NSString *failureReason  = @"No connection to the server";
    
    id responseObject = operation.response;
    if ([responseObject isKindOfClass:[NSDictionary class]])
    {
            errorJson = responseObject;
            if ([errorJson objectForKey:self.keyErrorDescription]) description     = [errorJson objectForKey:self.keyErrorDescription];
            if ([errorJson objectForKey:self.keyErrorFailureReason]) failureReason = [errorJson objectForKey:self.keyErrorFailureReason];
    }
    NSError *err = [NSError errorWithDomain:@"API"
                                       code:((NSHTTPURLResponse *)(operation.response)).statusCode
                                   userInfo:@{
                                              NSLocalizedDescriptionKey:description,
                                              NSLocalizedFailureReasonErrorKey: failureReason
                                              }];
    return err;
}

@end
