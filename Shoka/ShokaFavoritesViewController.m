//
//  ShokaFavoritesViewController.m
//  Shoka
//
//  Created by Xhacker on 2013-05-25.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaFavoritesViewController.h"
#import "ShokaFavorites.h"

@interface ShokaFavoritesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *favorites;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ShokaFavoritesViewController

- (void)viewDidLoad
{
    self.favorites = [ShokaFavorites list];
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    [super viewWillAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.favorites.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"book" sender:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.favorites[indexPath.row] name];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"book"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
//        [segue.destinationViewController setBook:self.favorites[indexPath.row]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
