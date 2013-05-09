//
//  ShokaResult.h
//  Shoka
//
//  Created by Xhacker on 2013-05-03.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShokaBook.h"

@interface ShokaResult : NSObject

@property (strong, nonatomic) NSDictionary *extraInfo;

- (void)addObject:(id)book;
- (NSInteger)count;
- (id)objectAtIndex:(NSInteger)index;
- (void)clear;
- (void)sortUsingKeyword:(NSString *)keyword;

@end
