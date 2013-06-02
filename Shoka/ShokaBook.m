//
//  ShokaBook.m
//  Shoka
//
//  Created by Xhacker on 2013-05-03.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaBook.h"

@implementation ShokaBook

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"title": @"title",
        @"ISBN": @"isbn",
        @"callNo": @"call_no",
        @"pages": @"pages",
        @"publisher": @"publisher",
        @"publishDate": @"publish_date",
        @"summary": @"summary",
        @"author": @"author",
        @"translator": @"translator",
        @"subject": @"subject",
        @"authors": @"authors",
        @"translators": @"translators",
        @"subjects": @"subjects",
        @"extraInfo": @"extra_info",
    };
}

+ (NSValueTransformer *)simpleTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^ id (NSArray *strings) {
        return strings;
    } reverseBlock:^ id (NSArray *objects) {
        return objects;
    }];
}

+ (NSValueTransformer *)authorsTransformer
{    
	return [ShokaBook simpleTransformer];
}

+ (NSValueTransformer *)translatorsTransformer
{
    return [ShokaBook simpleTransformer];
}

+ (NSValueTransformer *)subjectsTransformer
{
    return [ShokaBook simpleTransformer];
}

+ (NSValueTransformer *)extraInfoTransformer
{
    return [ShokaBook simpleTransformer];
}

@end
