//
//  ComidaCell.m
//  ZooAcamica
//
//  Created by Nicolás Porpiglia on 04/11/13.
//  Copyright (c) 2013 Nicolás Porpiglia. All rights reserved.
//

#import "ComidaCell.h"

@implementation ComidaCell

- (void) setImage: (NSString*) image {
    [imgFood setImage:[UIImage imageNamed:image]];
}

@end
