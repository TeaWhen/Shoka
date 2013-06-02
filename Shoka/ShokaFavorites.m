//
//  ShokaFavorites.m
//  Shoka
//
//  Created by Xhacker on 2013-05-03.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaFavorites.h"

static NSString * const kFavoritesKey = @"Favorites";
static NSString * const kFavoriteStorageFormat = @"%@|%@";

@implementation ShokaFavorites

+ (void)addBook:(ShokaBook *)book
{
#warning Need reload table view
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kFavoritesKey];
    NSMutableArray *favorites = [[NSKeyedUnarchiver unarchiveObjectWithData:data] mutableCopy];
    if (!favorites) {
        favorites = [[NSMutableArray alloc] init];
    }
    [favorites addObject:book];
    data = [NSKeyedArchiver archivedDataWithRootObject:favorites];
    [defaults setObject:data forKey:kFavoritesKey];
    [defaults synchronize];
}

+ (void)removeBook:(ShokaBook *)book
{
#warning Need reload table view
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kFavoritesKey];
    NSMutableArray *favorites = [[NSKeyedUnarchiver unarchiveObjectWithData:data] mutableCopy];
    [favorites removeObject:book];
    data = [NSKeyedArchiver archivedDataWithRootObject:favorites];
    [defaults setObject:data forKey:kFavoritesKey];
    [defaults synchronize];
}

+ (BOOL)hasBook:(ShokaBook *)book
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kFavoritesKey];
    NSArray *favorites = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (!favorites || [favorites indexOfObject:book] == NSNotFound) {
        return NO;
    }
    else {
        return YES;
    }
}

+ (NSArray *)list
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kFavoritesKey];
    NSArray *favorites = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return favorites;
}

@end
