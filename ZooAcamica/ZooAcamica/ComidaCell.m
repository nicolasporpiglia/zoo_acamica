//
//  ComidaCell.m
//  ZooAcamica
//
//  Created by Nicolás Porpiglia on 04/11/13.
//  Copyright (c) 2013 Nicolás Porpiglia. All rights reserved.
//

#import "ComidaCell.h"

@implementation ComidaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setImage: (NSString*) image {
    [imgFood setImage:[UIImage imageNamed:image]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
