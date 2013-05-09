//
//  ShokaResult.m
//  Shoka
//
//  Created by Xhacker on 2013-05-03.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaResult.h"
#import "NSString+Score.h"

#define FUZZINESS @0.5

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

- (void)sortUsingKeyword:(NSString *)keyword
{
    self.result = [[self.result sortedArrayUsingComparator:^NSComparisonResult(ShokaBook *a, ShokaBook *b) {
        NSString *firstTitle = a.title;
        NSString *secondTitle = b.title;
        return [[NSNumber numberWithFloat:[secondTitle scoreAgainst:keyword fuzziness:FUZZINESS]] compare:
                [NSNumber numberWithFloat:[firstTitle scoreAgainst:keyword fuzziness:FUZZINESS]]];
    }] mutableCopy];
}

@end
