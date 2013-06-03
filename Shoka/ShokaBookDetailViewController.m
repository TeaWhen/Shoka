//
//  ShokaBookDetailViewController.m
//  Shoka
//
//  Created by AquarHEAD L. on 5/5/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaBookDetailViewController.h"
#import "ShokaResult.h"
#import "ShokaItem.h"
#import "ShokaWebpacAPI.h"
#import "ShokaItemTableViewCell.h"
#import "ShokaFavorites.h"

#define kShokaBackIconName @"back"
#define kShokaFavorite0IconName @"favorite-0"
#define kShokaFavorite1IconName @"favorite-1"

@interface ShokaBookDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) ShokaResult *result;
@property (strong, nonatomic) NSArray *rowsInBasic;
@property (strong, nonatomic) NSMutableArray *availableRowsInBasic;
@property (strong, nonatomic) NSArray *rowsInMore;
@property (strong, nonatomic) NSMutableArray *availableRowsInMore;
@property (strong, nonatomic) UIButton *favoriteButton;

@end

@implementation ShokaBookDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backButton setImage:[UIImage imageNamed:kShokaBackIconName] forState:UIControlStateNormal];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    backButton.adjustsImageWhenHighlighted = NO;
    backButton.showsTouchWhenHighlighted = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.favoriteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.favoriteButton setImage:[UIImage imageNamed:kShokaFavorite0IconName] forState:UIControlStateNormal];
    [self.favoriteButton addTarget:self action:@selector(favoriteClicked) forControlEvents:UIControlEventTouchUpInside];
    self.favoriteButton.adjustsImageWhenHighlighted = NO;
    self.favoriteButton.showsTouchWhenHighlighted = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.favoriteButton];
    
    self.rowsInBasic = @[@"author", @"translator", @"publisher", @"publishDate", @"ISBN"];
    self.rowsInMore = @[@"subject", @"summary"];
    
    self.title = self.book.title;
    [self updateFavoriteButton];
    
    [ShokaWebpacAPI fetchItemDataOfDocNumber:[self.book.extraInfo valueForKey:@"webpac_docNumber"] inBase:[self.book.extraInfo valueForKey:@"webpac_base"] success:^(ShokaResult *api_result) {
        self.result = api_result;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:itemsSection] withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^(NSError *err) {
        NSLog(@"Failed fetch item data.");
    }];
}

enum section {
    basicInfoSection = 0,
    moreInfoSection,
    itemsSection,
    numOfSections
};

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return numOfSections;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == itemsSection) {
        return @"单册";
    }
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == basicInfoSection) {
        self.availableRowsInBasic = [NSMutableArray new];
        for (NSString *rowName in self.rowsInBasic) {
            if ([[self.book valueForKey:rowName] length] > 0) {
                [self.availableRowsInBasic addObject:rowName];
            }
        }
        return self.availableRowsInBasic.count;
    }
    else if (section == moreInfoSection) {
        self.availableRowsInMore = [NSMutableArray new];
        for (NSString *rowName in self.rowsInMore) {
            if ([[self.book valueForKey:rowName] length] > 0) {
                [self.availableRowsInMore addObject:rowName];
            }
        }
        return self.availableRowsInMore.count;
    }
    else if (section == itemsSection) {
        if (self.book.callNo.length > 0) {
            return self.result.count + 1;
        }
        return self.result.count;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier;
    if (indexPath.section == itemsSection) {
        if (self.book.callNo.length > 0 && indexPath.row == 0) {
            CellIdentifier = @"cellWithDefaultHeight";
        }
        else {
            CellIdentifier = @"item";
        }
    }
    else {
        CellIdentifier = @"cellWithDefaultHeight";
    }
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    return cell.bounds.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.section == basicInfoSection) {
        NSString *rowName = self.availableRowsInBasic[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:rowName];
        cell.detailTextLabel.text = [self.book valueForKey:rowName];
    }
    else if (indexPath.section == moreInfoSection) {
        NSString *rowName = self.availableRowsInMore[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:rowName];
        cell.detailTextLabel.text = [self.book valueForKey:rowName];
    }
    else if (indexPath.section == itemsSection) {
        NSInteger index = indexPath.row;
        if (self.book.callNo.length > 0) {
            index = index - 1;
        }
        
        if (index == -1) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"callNo"];
            cell.detailTextLabel.text = self.book.callNo;
        }
        else {
            ShokaItemTableViewCell *itemCell;
            itemCell = [tableView dequeueReusableCellWithIdentifier:@"item"];
            
            ShokaItem *item = [self.result objectAtIndex:index];
            
            itemCell.statusLabel.text = item.status;
            itemCell.libraryLabel.text = item.library;
            
            cell = itemCell;
        }
    }
    
	return cell;
}

- (void)favoriteClicked
{
    if ([ShokaFavorites hasBook:self.book]) {
        [ShokaFavorites removeBook:self.book];
    }
    else {
        [ShokaFavorites addBook:self.book];
    }
    [self updateFavoriteButton];
}

- (void)updateFavoriteButton
{
    if ([ShokaFavorites hasBook:self.book]) {
        [self.favoriteButton setImage:[UIImage imageNamed:kShokaFavorite1IconName] forState:UIControlStateNormal];
    }
    else {
        [self.favoriteButton setImage:[UIImage imageNamed:kShokaFavorite0IconName] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
