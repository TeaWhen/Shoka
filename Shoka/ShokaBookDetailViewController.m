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

@interface ShokaBookDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) ShokaResult *result;
@property NSArray *rowsInBasic;
@property NSMutableArray *availableRowsInBasic;
@property NSArray *rowsInMore;

@end

@implementation ShokaBookDetailViewController

- (ShokaResult *)result
{
    if (!_result) _result = [ShokaResult new];
    return _result;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.rowsInBasic = @[@"author", @"translator", @"publisher", @"publishDate", @"ISBN", @"callNo"];
    self.rowsInMore = @[@"subject", @"summary"];
    
    NSLog(@"view detail: %@", self.book);
    
    self.title = self.book.title;
    
    [ShokaWebpacAPI fetchItemDataOfDocNumber:[self.book.extraInfo valueForKey:@"webpac_docNumber"] inBase:[self.book.extraInfo valueForKey:@"webpac_base"] success:^(ShokaResult *api_result) {
        self.result = api_result;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:itemsSection] withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^(NSError *err) {
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
            if ([self.book valueForKey:rowName]) {
                [self.availableRowsInBasic addObject:rowName];
            }
        }
        return self.availableRowsInBasic.count;
    }
    else if (section == moreInfoSection) {
        return self.rowsInMore.count;
    }
    else if (section == itemsSection) {
        return [self.result count];
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier;
    if (indexPath.section == itemsSection) {
        CellIdentifier = @"item";
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
        NSString *rowName = self.rowsInMore[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:rowName];
        cell.detailTextLabel.text = [self.book valueForKey:rowName];
    }
    else if (indexPath.section == itemsSection) {
        ShokaItemTableViewCell *itemCell;
        itemCell = [tableView dequeueReusableCellWithIdentifier:@"item"];
        
        ShokaItem *item = [self.result objectAtIndex:indexPath.row];
        
        itemCell.statusLabel.text = item.status;
        itemCell.libraryLabel.text = item.library;
        
        cell = itemCell;
    }
    
	return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
