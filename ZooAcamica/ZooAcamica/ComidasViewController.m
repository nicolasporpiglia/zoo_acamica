//
//  ComidasViewController.m
//  ZooAcamica
//
//  Created by Matias Paillet on 11/4/13.
//  Copyright (c) 2013 Nicolás Porpiglia. All rights reserved.
//

#import "ComidasViewController.h"

@interface ComidasViewController ()

@end

@implementation ComidasViewController

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

    [tableFoods registerNib:[UINib nibWithNibName:@"ComidaCell"
                                               bundle:[NSBundle mainBundle]]
                    forCellReuseIdentifier:@"ComidaCell"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ComidaCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"ComidaCell"];
    
    if (!cell) {
        cell = [[ComidaCell alloc] init];
        [cell setImage:[NSString stringWithFormat:@"Food_%d.jpg", indexPath.row]];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

-(void) tableView: (UITableView*) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
