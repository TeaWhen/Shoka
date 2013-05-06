//
//  ShokaWebpacAPI.m
//  Shoka
//
//  Created by AquarHEAD L. on 5/4/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaWebpacAPI.h"
#import "AFNetworking.h"
#import "RXMLElement.h"

#import "ShokaBook.h"
#import "ShokaItem.h"

#define SETENTRY @"1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100"

@implementation ShokaWebpacAPI

+ (void)detectBaseURLFor: (void (^)(NSURL *baseURL))func
{
    NSURLRequest *detectRequest = [NSURLRequest requestWithURL: [NSURL URLWithString:@"http://10.10.16.94/X?op=find&base=zju01&code=wrd&request=teawhen"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:1];
    AFHTTPRequestOperation *detectOP = [[AFHTTPRequestOperation alloc] initWithRequest:detectRequest];
    [detectOP setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"in zju");
        func([NSURL URLWithString:@"http://10.10.16.94"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"out zju");
        func([NSURL URLWithString:@"http://webpac.zju.edu.cn"]);
    }];
    
    [detectOP start];
}

+ (void)searchChineseDepositoryWithKey:(NSString *)searchKey success:(void (^)(ShokaResult *))success failure:(void (^)(NSError *))failure
{
    ShokaResult *result = [ShokaResult new];
    [ShokaWebpacAPI detectBaseURLFor:^(NSURL *baseURL)
    {
        NSString *requestString = [[NSString stringWithFormat:@"/X?op=find&base=zju01&code=wrd&request=%@", searchKey] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperation *searchOP = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestString relativeToURL:baseURL]]];
        [searchOP setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            // First get set_number
            RXMLElement *rootXML = [RXMLElement elementFromXMLData:responseObject];
            NSString *searchSetString = [[NSString stringWithFormat:@"/X?op=present&set_no=%@&set_entry=%@&format=marc", [rootXML child:@"set_number"].text, SETENTRY] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            AFHTTPRequestOperation *searchSetOP = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:searchSetString relativeToURL:baseURL]]];
            [searchSetOP setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
            {
                RXMLElement *recordsRootXML = [RXMLElement elementFromXMLData:responseObject];
                [recordsRootXML iterate:@"record" usingBlock:^(RXMLElement *record)
                {
                    ShokaBook *bk = [ShokaBook new];
                    [bk.extraInfo setValue:record forKey:@"webpac_rawData"];
                    [bk.extraInfo setValue:[record child:@"doc_number"] forKey:@"webpac_docNumber"];
                    [bk.extraInfo setValue:@"zju01" forKey:@"webpac_base"];
                    [record iterate:@"metadata.oai_marc.varfield" usingBlock:^(RXMLElement *vf)
                    {
                        if ([[vf attribute:@"id"] isEqualToString:@"200"]) {
                            [vf iterate:@"subfield" usingBlock:^(RXMLElement *sf)
                            {
                                if ([[sf attribute:@"label"] isEqualToString:@"a"]) {
                                    bk.title = sf.text;
                                }
                            }];
                        }
                    }];
                    [result addObject:bk];
                }];
                success(result);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error)
            {
                NSLog(@"failure while querying records");
            }];
            
            [searchSetOP start];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            NSLog(@"failure while querying set_number");
        }];

        [searchOP start];
    }];
}

+ (void)searchForeignDepositoryWithKey:(NSString *)searchKey success:(void (^)(ShokaResult *))success failure:(void (^)(NSError *))failure
{
    ShokaResult *result = [ShokaResult new];
    [ShokaWebpacAPI detectBaseURLFor:^(NSURL *baseURL)
    {
        NSString *requestString = [[NSString stringWithFormat:@"/X?op=find&base=zju09&code=wrd&request=%@", searchKey] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperation *searchOP = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestString relativeToURL:baseURL]]];
        [searchOP setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            // First get set_number
            RXMLElement *rootXML = [RXMLElement elementFromXMLData:responseObject];
            NSString *searchSetString = [[NSString stringWithFormat:@"/X?op=present&set_no=%@&set_entry=%@&format=marc", [rootXML child:@"set_number"].text, SETENTRY] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            AFHTTPRequestOperation *searchSetOP = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:searchSetString relativeToURL:baseURL]]];
            [searchSetOP setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
            {
                RXMLElement *recordsRootXML = [RXMLElement elementFromXMLData:responseObject];
                [recordsRootXML iterate:@"record" usingBlock:^(RXMLElement *record)
                {
                    ShokaBook *bk = [ShokaBook new];
                    [bk.extraInfo setValue:record forKey:@"webpac_rawData"];
                    [bk.extraInfo setValue:[record child:@"doc_number"] forKey:@"webpac_docNumber"];
                    [bk.extraInfo setValue:@"zju09" forKey:@"webpac_base"];
                    [record iterate:@"metadata.oai_marc.varfield" usingBlock:^(RXMLElement *vf)
                    {
                        if ([[vf attribute:@"id"] isEqualToString:@"245"]) {
                            [vf iterate:@"subfield" usingBlock:^(RXMLElement *sf)
                            {
                                if ([[sf attribute:@"label"] isEqualToString:@"a"]) {
                                    bk.title = [ShokaWebpacAPI cleanupTitle:sf.text];
                                }
                            }];
                        }
                    }];
                    [result addObject:bk];
                }];
                success(result);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error)
            {
                NSLog(@"failure while querying records");
            }];
            
            [searchSetOP start];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            NSLog(@"failure while querying set_number");
        }];
        
        [searchOP start];
    }];
}

+ (void)searchDepositoryWithKey:(NSString *)searchKey success:(void (^)(ShokaResult *))success failure:(void (^)(NSError *))failure
{
}

+ (void)fetchItemDataOfDocNumber:(NSString *)docNumber inBase:(NSString *)base success:(void (^)(ShokaResult *))success failure:(void (^)(NSError *))failure
{
    ShokaResult *result = [ShokaResult new];
    [ShokaWebpacAPI detectBaseURLFor:^(NSURL *baseURL) {
        NSString *requestString = [[NSString stringWithFormat:@"http://webpac.zju.edu.cn/X?op=item-data&base=%@&doc_number=%@", base, docNumber] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestString relativeToURL:baseURL]]];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            RXMLElement *itemData = [RXMLElement elementFromXMLData:responseObject];
            [itemData iterate:@"item" usingBlock:^(RXMLElement *item)
            {
                ShokaItem *itm = [ShokaItem new];
                NSString *dueDate = [item child:@"loan-due-date"].text;
                if (dueDate) {
                    itm.status = [NSString stringWithFormat:@"已借出, %@", dueDate];
                }
                else {
                    if ([[item child:@"item-status"].text isEqualToString:@"12"]) {
                        itm.status = @"普通外借";
                    } else {
                        itm.status = @"图书借阅";
                    }
                }
                itm.library = [item child:@"sub-library"].text;
                itm.callNo = [item child:@"call-no-1"].text;
                itm.rawData = item;
                [result addObject:itm];
            }];
            success(result);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            NSLog(@"failure when fetching item data");
        }];
        
        [operation start];
    }];
    
}

+ (NSString *)cleanupTitle:(NSString *)origin
{
    return [origin stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=/"]];
}

@end
