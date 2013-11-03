//
//  HomeViewController.m
//  ZooAcamica
//
//  Created by Matias Paillet on 11/3/13.
//  Copyright (c) 2013 Nicolás Porpiglia. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController () {
    IBOutlet UILabel* nombre;
}

@end

@implementation HomeViewController

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
    
    // Do any additional setup after loading the view from its nib.
    [nombre setText:@"Panchito"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
