//
//  ShokaViewController.m
//  Shoka
//
//  Created by AquarHEAD L. on 4/12/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaViewController.h"
#import "ShokaResult.h"
#import "ShokaWebpacAPI.h"
#import "ShokaBookDetailViewController.h"

@interface ShokaViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property ShokaResult *cn_result, *en_result;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ShokaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.cn_result = [ShokaResult new];
    self.en_result = [ShokaResult new];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchKey = searchBar.text;
    [ShokaWebpacAPI searchChineseDepositoryWithKey:searchKey success:^(ShokaResult *result) {
        [result sortUsingKeyword:searchKey];
        self.cn_result = result;
        if (self.searchBar.selectedScopeButtonIndex == Chinese) {
            [self.tableView reloadData];
            [self.tableView setContentOffset:CGPointZero];
        }
    } failure:^(NSError *error) {
    }];
    [ShokaWebpacAPI searchForeignDepositoryWithKey:searchKey success:^(ShokaResult *result) {
        [result sortUsingKeyword:searchKey];
        self.en_result = result;
        if (self.searchBar.selectedScopeButtonIndex == Western) {
            [self.tableView reloadData];
            [self.tableView setContentOffset:CGPointZero];
        }
    } failure:^(NSError *error) {
    }];
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

enum Language {
    Chinese = 0,
    Western
};

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchBar.selectedScopeButtonIndex == Chinese)
        return [self.cn_result count];
    else
        return [self.en_result count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    ShokaBook *bk;
    if (self.searchBar.selectedScopeButtonIndex == Chinese)
        bk = [self.cn_result objectAtIndex:indexPath.row];
    else
        bk = [self.en_result objectAtIndex:indexPath.row];
    
    cell.textLabel.text = bk.title;
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"book" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"book"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        if (self.searchBar.selectedScopeButtonIndex == Chinese)
            [segue.destinationViewController setBook:[self.cn_result objectAtIndex:indexPath.row]];
        else
            [segue.destinationViewController setBook:[self.en_result objectAtIndex:indexPath.row]];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
