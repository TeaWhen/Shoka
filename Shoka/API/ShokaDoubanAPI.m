//
//  ShokaDoubanAPI.m
//  Shoka
//
//  Created by AquarHEAD L. on 5/4/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaDoubanAPI.h"
#import <AFNetworking.h>

@implementation ShokaDoubanAPI

#define API_TIMEOUT 5

+ (void)searchBookWithISBN:(NSString *)isbn success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    NSString *requestString = [[NSString stringWithFormat:@"http://api.douban.com/v2/book/isbn/%@", isbn] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperation *searchOP = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:API_TIMEOUT]];
    searchOP.responseSerializer = [AFJSONResponseSerializer serializer];
    [searchOP setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure([NSError errorWithDomain:@"DoubanAPI" code:4 userInfo:@{@"status": @"failure while searching book with isbn"}]);
    }];
    [searchOP start];
}

@end
