//
//  EstadoMascota.h
//  ZooAcamica
//
//  Created by Matias Paillet on 11/13/13.
//  Copyright (c) 2013 Nicolás Porpiglia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EstadoMascota : NSObject

+ (id) sharedInstance;
- (void) ingirioComida;
- (void) ejercitar;

@property(atomic,assign) int energia;

@end
