//
//  ShokaFavorites.h
//  Shoka
//
//  Created by Xhacker on 2013-05-03.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShokaBook.h"

@interface ShokaFavorites : NSObject

+ (void)addBook:(ShokaBook *)book;
+ (void)removeBook:(ShokaBook *)book;
+ (BOOL)hasBook:(ShokaBook *)book;
+ (NSArray *)list;

@end
