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

@interface ShokaBookDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) ShokaResult *result;

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
    
    NSLog(@"%@", self.book);
    
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

enum rowInBasic {
    authorRow = 0,
    publisherRow,
    ISBNRow,
    numOfRowsInBasic
};

enum rowInMore {
    subjectRow = 0,
    summaryRow,
    numOfRowsInMore
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
        return numOfRowsInBasic;
    }
    else if (section == moreInfoSection) {
        return numOfRowsInMore;
    }
    else if (section == itemsSection) {
        return [self.result count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.section == basicInfoSection) {
        if (indexPath.row == authorRow) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Author"];
            cell.detailTextLabel.text = self.book.author;
        }
        else if (indexPath.row == publisherRow) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Publisher"];
            cell.detailTextLabel.text = self.book.publisher;
        }
        else if (indexPath.row == ISBNRow) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ISBN"];
            cell.detailTextLabel.text = self.book.ISBN;
        }
    }
    else if (indexPath.section == moreInfoSection) {
        if (indexPath.row == subjectRow) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Subject"];
            cell.detailTextLabel.text = self.book.subject;
        }
        else if (indexPath.row == summaryRow) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Summary"];
            cell.detailTextLabel.text = self.book.summary;
        }
    }
    else if (indexPath.section == itemsSection) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ItemDetail"];
        
        ShokaItem *item = [self.result objectAtIndex:indexPath.row];
        
        cell.textLabel.text = item.library;
        cell.detailTextLabel.text = item.status;
    }
    
	return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
