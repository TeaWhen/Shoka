//
//  ShokaBookDetailViewController.m
//  Shoka
//
//  Created by AquarHEAD L. on 5/5/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaBookDetailViewController.h"

@interface ShokaBookDetailViewController ()

@end

@implementation ShokaBookDetailViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
