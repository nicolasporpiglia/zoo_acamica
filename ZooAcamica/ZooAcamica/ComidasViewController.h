//
//  ComidasViewController.h
//  ZooAcamica
//
//  Created by Matias Paillet on 11/4/13.
//  Copyright (c) 2013 Nicolás Porpiglia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComidaCell.h"

@interface ComidasViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UITableView *tableFoods;
}

@end
