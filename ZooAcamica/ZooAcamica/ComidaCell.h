//
//  ComidaCell.h
//  ZooAcamica
//
//  Created by Nicolás Porpiglia on 04/11/13.
//  Copyright (c) 2013 Nicolás Porpiglia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComidaCell : UITableViewCell{
    IBOutlet UIImageView *imgFood;
}

- (void) setImage: (NSString*) image;

@end
