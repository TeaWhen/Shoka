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
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ShokaBookDetailViewController

- (ShokaResult *)result
{
    if (!_result) _result = [ShokaResult new];
    return _result;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.book.title;
    [ShokaWebpacAPI fetchItemDataOfDocNumber:[self.book.extraInfo valueForKey:@"webpac_docNumber"] inBase:[self.book.extraInfo valueForKey:@"webpac_base"] success:^(ShokaResult *api_result) {
        self.result = api_result;
        [self.tableView reloadData];
    } failure:^(NSError *err) {
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.result count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookDetail"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    ShokaItem *item = [self.result objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.library;
    cell.detailTextLabel.text = item.status;
    
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.result count] > 0) {
        ShokaItem *item = [self.result objectAtIndex:0];
        return item.callNo;
    }
    return @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
