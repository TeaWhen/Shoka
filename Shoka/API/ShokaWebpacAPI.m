//
//  ShokaWebpacAPI.m
//  Shoka
//
//  Created by AquarHEAD L. on 5/4/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaWebpacAPI.h"
#import "AFNetworking.h"

@implementation ShokaWebpacAPI

//+ (void)detectBaseURLsuccess:

+ (void)searchChineseDepositoryWithKey:(NSString *)searchKey success:(void (^)(id))success failure:(void (^)(NSError *))failure
{

    NSURLRequest *testLocationRequest = [NSURLRequest requestWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"http://10.10.16.94/X?op=find&base=zju01&code=wrd&request=%@", searchKey]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:0.1];
    AFXMLRequestOperation *testLocationOP = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:testLocationRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser)
    {
        // in zju
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser)
    {
        // out zju
    }];
    
    [testLocationOP start];
}

+ (void)searchForeignDepositoryWithKey:(NSString *)searchKey success:(void (^)(id))data failure:(void (^)(NSError *))error
{
}

+ (void)searchDepositoryWithKey:(NSString *)searchKey success:(void (^)(id))data failure:(void (^)(NSError *))error
{
}

@end
