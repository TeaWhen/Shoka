//
//  ShokaBook.m
//  Shoka
//
//  Created by Xhacker on 2013-05-03.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaBook.h"

@implementation ShokaBook

- (NSMutableDictionary *)extraInfo
{
    if (!_extraInfo) _extraInfo = [NSMutableDictionary new];
    
    return _extraInfo;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"｢%@｣ _%@_", self.title, [self.extraInfo valueForKey:@"webpac_docNumber"]];
}

@end
