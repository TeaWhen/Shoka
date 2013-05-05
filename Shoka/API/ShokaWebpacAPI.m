//
//  ShokaWebpacAPI.m
//  Shoka
//
//  Created by AquarHEAD L. on 5/4/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaWebpacAPI.h"
#import "AFNetworking.h"
#import "AFKissXMLRequestOperation.h"
#import "RXMLElement.h"

@implementation ShokaWebpacAPI

+ (void)detectBaseURLFor: (void (^)(NSURL *baseURL))func
{
    NSURLRequest *detectRequest = [NSURLRequest requestWithURL: [NSURL URLWithString:@"http://10.10.16.94/X?op=find&base=zju01&code=wrd&request=teawhen"]];
    AFXMLRequestOperation *detectOP = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:detectRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
        NSLog(@"in zju");
        func([NSURL URLWithString:@"http://10.10.16.94"]);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
        NSLog(@"out zju");
        func([NSURL URLWithString:@"http://webpac.zju.edu.cn"]);
    }];
    
    [detectOP start];
}

+ (void)searchChineseDepositoryWithKey:(NSString *)searchKey success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:0.1
    [ShokaWebpacAPI detectBaseURLFor:^(NSURL *baseURL) {
        NSString *requestString = [[NSString stringWithFormat:@"/X?op=find&base=zju09&code=wrd&request=%@", searchKey] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"the request string is: %@", requestString);
        AFKissXMLRequestOperation *operation = [AFKissXMLRequestOperation XMLDocumentRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestString relativeToURL:baseURL]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, DDXMLDocument *XMLDocument) {
            NSLog(@"XMLDocument: %@", XMLDocument);
            RXMLElement *rootXML = [RXMLElement elementFromXMLString:[NSString stringWithFormat:@"%@", XMLDocument] encoding:NSUTF8StringEncoding];
            NSLog(@"%@", [rootXML child:@"set_number"]);
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, DDXMLDocument *XMLDocument) {
            NSLog(@"failure");
        }];
        
        [operation start];
    }];
}

+ (void)searchForeignDepositoryWithKey:(NSString *)searchKey success:(void (^)(id))data failure:(void (^)(NSError *))error
{
}

+ (void)searchDepositoryWithKey:(NSString *)searchKey success:(void (^)(id))data failure:(void (^)(NSError *))error
{
}

@end
