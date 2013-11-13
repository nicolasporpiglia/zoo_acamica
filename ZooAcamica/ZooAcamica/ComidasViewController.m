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

- (void)viewDidLoad
{
    [super viewDidLoad];

    [tableFoods registerNib:[UINib nibWithNibName:@"ComidaCell" bundle:[NSBundle mainBundle]]
                    forCellReuseIdentifier:@"ComidaCell"];
    [tableFoods reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ComidaCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"ComidaCell"];
    
    if (!cell) {
        cell = [[ComidaCell alloc] init];
    }
    
    [cell setImage:[NSString stringWithFormat:@"comida_%d.png", indexPath.row]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

-(void) tableView: (UITableView*) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.delegate respondsToSelector:@selector(didSelectedComida:)]) {
        [self.delegate didSelectedComida:[NSString stringWithFormat:@"comida_%d.png", indexPath.row]];
    }
}

@end
