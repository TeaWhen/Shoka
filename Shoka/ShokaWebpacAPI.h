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

+ (ShokaResult *)searchDepositoryWithKey:(NSString *)searchKey;
+ (ShokaResult *)searchChineseDepositoryWithKey:(NSString *)searchKey;
+ (ShokaResult *)searchForeignDepositoryWithKey:(NSString *)searchKey;

@end
