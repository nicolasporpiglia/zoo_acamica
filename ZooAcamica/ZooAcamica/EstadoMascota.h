//
//  EstadoMascota.h
//  ZooAcamica
//
//  Created by Matias Paillet on 11/13/13.
//  Copyright (c) 2013 Nicolás Porpiglia. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NOTIFICACION_MASCOTA_SIN_ENERGIA @"MASCOTA_SIN_ENERGIA"
#define NOTIFICACION_MASCOTA_CON_ENERGIA @"MASCOTA_CON_ENERGIA"

@interface EstadoMascota : NSObject

+ (id) sharedInstance;
- (void) ingirioComida;
- (void) ejercitar;

@property(atomic,assign) float energia;
@property(atomic,assign) int experiencia;
@property(atomic,assign) int nivel;
@property(nonatomic,retain) NSString* nombre;

@end
