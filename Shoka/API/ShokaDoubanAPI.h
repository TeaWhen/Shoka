//
//  ShokaDoubanAPI.h
//  Shoka
//
//  Created by AquarHEAD L. on 5/4/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShokaDoubanAPI : NSObject

+ (void)searchBookWithISBN:(NSString *)isbn success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure;

@end
