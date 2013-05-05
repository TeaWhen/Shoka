//
//  ShokaWebpacAPI.h
//  Shoka
//
//  Created by AquarHEAD L. on 5/4/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShokaResult.h"

@interface ShokaWebpacAPI : NSObject

+ (void)searchDepositoryWithKey:(NSString *)searchKey success:(void (^)(ShokaResult *))success failure:(void (^)(NSError *))failure;
+ (void)searchChineseDepositoryWithKey:(NSString *)searchKey success:(void (^)(ShokaResult *))success failure:(void (^)(NSError *))failure;
+ (void)searchForeignDepositoryWithKey:(NSString *)searchKey success:(void (^)(ShokaResult *))success failure:(void (^)(NSError *))failure;

+ (void)fetchItemDataOfDocNumber:(NSString *)docNumber inBase:(NSString *)base success:(void (^)(ShokaResult *))success failure:(void (^)(NSError *))failure;

@end
