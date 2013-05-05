//
//  ShokaResult.m
//  Shoka
//
//  Created by Xhacker on 2013-05-03.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaResult.h"

@interface ShokaResult ()

@property (strong, nonatomic) NSMutableArray *result;

@end

@implementation ShokaResult

- (NSMutableArray *)result
{
    if (!_result) _result = [NSMutableArray new];
    
    return _result;
};

- (void)addObject:(id)obj
{
    [self.result addObject:obj];
}

- (NSInteger)count
{
    return [self.result count];
}

- (id)objectAtIndex:(NSInteger)index
{
    return [self.result objectAtIndex:index];
}

- (void)clear
{
    [self.result removeAllObjects];
}

@end
