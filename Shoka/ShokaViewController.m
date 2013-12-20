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
#import "ShokaGrayView.h"

#import "SVProgressHUD.h"
#import <DLAVAlertView.h>

@interface ShokaViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property ShokaResult *cn_result, *en_result;
@property bool cn_done, en_done, search_failure;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet ShokaGrayView *grayView;

- (void)keyboardWillShow:(NSNotification*)notification;
- (void)keyboardWillHide:(NSNotification*)notification;
- (NSTimeInterval)keyboardAnimationDurationForNotification:(NSNotification*)notification;

@end

@implementation ShokaViewController

enum Language {
    Chinese = 0,
    Western
};

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.cn_result = [ShokaResult new];
    self.en_result = [ShokaResult new];
    self.cn_done = false;
    self.en_done = false;
    self.search_failure = false;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismissHUD:)
                                                 name:@"SearchDone"
                                               object:nil];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 49, 0);
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    [self.grayView setGray:YES withDuration:[self keyboardAnimationDurationForNotification:notification]];
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    [self.grayView setGray:NO withDuration:[self keyboardAnimationDurationForNotification:notification]];
}

- (NSTimeInterval)keyboardAnimationDurationForNotification:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval duration = 0;
    [value getValue:&duration];
    return duration;
}

- (IBAction)grayViewTouched:(UITapGestureRecognizer *)sender {
    [self.searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchKey = searchBar.text;
    [SVProgressHUD showWithStatus:@"载入中…" maskType:SVProgressHUDMaskTypeClear];
    [ShokaWebpacAPI searchChineseDepositoryWithKey:searchKey success:^(ShokaResult *result) {
        [result sortUsingKeyword:searchKey];
        self.cn_result = result;
        if (self.searchBar.selectedScopeButtonIndex == Chinese) {
            [self.tableView reloadData];
            [self.tableView setContentOffset:CGPointZero];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchDone" object:self userInfo:@{@"status": @"success", @"repo": @"CN"}];
        if ([result.extraInfo[@"no_records"] intValue] > [result.extraInfo[@"no_entries"] intValue]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"返回结果过多" message:@"仅显示了前 100 条，请尝试更精确的关键词" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alertView show];
        }
    } failure:^(NSError *error) {
        self.cn_result = [ShokaResult new];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchDone" object:self userInfo:@{@"status": @"failure", @"repo": @"CN"}];
    }];
    [ShokaWebpacAPI searchForeignDepositoryWithKey:searchKey success:^(ShokaResult *result) {
        [result sortUsingKeyword:searchKey];
        self.en_result = result;
        if (self.searchBar.selectedScopeButtonIndex == Western) {
            [self.tableView reloadData];
            [self.tableView setContentOffset:CGPointZero];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchDone" object:self userInfo:@{@"status": @"success", @"repo": @"EN"}];
    } failure:^(NSError *error) {
        self.en_result = [ShokaResult new];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchDone" object:self userInfo:@{@"status": @"failure", @"repo": @"EN"}];
    }];
    [searchBar resignFirstResponder];
}

- (void)dismissHUD:(NSNotification*)notification
{
    if ([[[notification userInfo] valueForKey:@"repo"] isEqualToString:@"CN"]) {
        if ([[[notification userInfo] valueForKey:@"status"] isEqualToString:@"failure"]) {
            if (self.searchBar.selectedScopeButtonIndex == Chinese) {
                [SVProgressHUD showErrorWithStatus:@"载入失败"];
            }
            self.search_failure = true;
        }
        self.cn_done = true;
    }
    else {
        if ([[[notification userInfo] valueForKey:@"status"] isEqualToString:@"failure"]) {
            if (self.searchBar.selectedScopeButtonIndex == Western) {
                [SVProgressHUD showErrorWithStatus:@"载入失败"];
            }
            self.search_failure = true;
        }
        self.en_done = true;
    }
    
    if (self.cn_done && self.en_done) {
        if (self.search_failure) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                [SVProgressHUD dismiss];
            });
        }
        else {
            [SVProgressHUD dismiss];
        }
        self.cn_done = false;
        self.en_done = false;
        self.search_failure = false;
    }
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

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
    
    ShokaBook *book;
    if (self.searchBar.selectedScopeButtonIndex == Chinese)
        book = [self.cn_result objectAtIndex:indexPath.row];
    else
        book = [self.en_result objectAtIndex:indexPath.row];
    
    cell.textLabel.text = book.title;
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"book" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"book"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        if (self.searchBar.selectedScopeButtonIndex == Chinese)
            [segue.destinationViewController setBook:[self.cn_result objectAtIndex:indexPath.row]];
        else
            [segue.destinationViewController setBook:[self.en_result objectAtIndex:indexPath.row]];
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    }
}

@end
