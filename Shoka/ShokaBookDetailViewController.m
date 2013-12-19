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
#import "ShokaDoubanAPI.h"

#define kShokaBackIconName @"back"
#define kShokaFavorite0IconName @"favorite-0"
#define kShokaFavorite1IconName @"favorite-1"

const NSInteger kShokaCellLabelWidth = 250;
const NSInteger kShokaCellLabelExtraHeight = 24;

@interface ShokaBookDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) ShokaResult *result;
@property (strong, nonatomic) NSDictionary *doubanInfo;
@property (strong, nonatomic) NSArray *rowsInBasic;
@property (strong, nonatomic) NSMutableArray *availableRowsInBasic;
@property (strong, nonatomic) NSArray *rowsInMore;
@property (strong, nonatomic) NSMutableArray *availableRowsInMore;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *favoriteButton;

@end

@implementation ShokaBookDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.rowsInBasic = @[@"author", @"translator", @"publisher", @"publishDate", @"ISBN"];
    self.rowsInMore = @[@"subject", @"summary"];
    
    self.title = self.book.title;
    [self updateFavoriteButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 240, 40)];
    titleLabel.text = self.title;
    titleLabel.font = [UIFont boldSystemFontOfSize:19.0];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.minimumScaleFactor = 0.7;
    titleLabel.numberOfLines = 2;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel sizeToFit];
    NSInteger numLines = (NSInteger)(titleLabel.frame.size.height / titleLabel.font.leading);
    if (numLines > 1) {
        titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    }
    self.navigationItem.titleView = titleLabel;
    
    [ShokaWebpacAPI fetchItemDataOfDocNumber:[self.book.extraInfo valueForKey:@"webpac_docNumber"] inBase:[self.book.extraInfo valueForKey:@"webpac_base"] success:^(ShokaResult *api_result) {
        self.result = api_result;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:itemsSection] withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^(NSError *err) {
        NSLog(@"%@", err.userInfo[@"status"]);
    }];

    [ShokaDoubanAPI searchBookWithISBN:self.book.ISBN success:^(NSDictionary *doubanInfo) {
        self.doubanInfo = doubanInfo;
    } failure:^(NSError *err) {
        NSLog(@"%@", err.userInfo[@"status"]);
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
        NSString *rowName;
        if (indexPath.section == basicInfoSection) {
            rowName = self.availableRowsInBasic[indexPath.row];
        }
        else if (indexPath.section == moreInfoSection) {
            rowName = self.availableRowsInMore[indexPath.row];
        }

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rowName];
        NSString *text = [self.book valueForKey:rowName];
        CGSize size = [text boundingRectWithSize:CGSizeMake(kShokaCellLabelWidth, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: cell.detailTextLabel.font} context:nil].size;
        
        return size.height + kShokaCellLabelExtraHeight;
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


- (IBAction)favoriteClicked:(UIBarButtonItem *)sender
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
        self.favoriteButton.image = [UIImage imageNamed:kShokaFavorite1IconName];
    }
    else {
        self.favoriteButton.image = [UIImage imageNamed:kShokaFavorite0IconName];
    }
}

@end
