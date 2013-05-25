//
//  ShokaFavorites.h
//  Shoka
//
//  Created by Xhacker on 2013-05-03.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShokaFavorites : NSObject

+ (void)addBookWithDocNumber:(NSString *)number andBase:(NSString *)base;
+ (void)removeBookWithDocNumber:(NSString *)number andBase:(NSString *)base;
+ (BOOL)hasBookWithDocNumber:(NSString *)number andBase:(NSString *)base;
+ (NSArray *)list;

@end
