//
//  EstadoMascota.m
//  ZooAcamica
//
//  Created by Matias Paillet on 11/13/13.
//  Copyright (c) 2013 Nicolás Porpiglia. All rights reserved.
//

#import "EstadoMascota.h"

static EstadoMascota *instance;

@implementation EstadoMascota

+ (id) sharedInstance {
    if(!instance) {
        instance = [[EstadoMascota alloc] init];
    }
    
    return instance;
}

- (id) init {
    self = [super init];
    
    if(self) {
        self.energia = 10;
        self.experiencia = 0;
        self.nivel = 0;
    }
    
    return self;
}

- (void) ingirioComida {
    
    if(self.energia == 0) {
       [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICACION_MASCOTA_CON_ENERGIA object:nil];
    }
    
    self.energia += 50;
    
    if(self.energia > 100) {
        self.energia = 100;
    }
}

- (void) ejercitar {
    self.energia-= 10;
    
    if (self.energia < 0) {
        self.energia = 0;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICACION_MASCOTA_SIN_ENERGIA object:nil];
    }
    
    [self aumentarExperiencia];
}

- (void) aumentarExperiencia {
    self.experiencia+= 10;
    
    if((self.nivel < 5 && self.experiencia > 100)
       || (self.experiencia > 250)) {
        self.nivel ++;
        self.experiencia = 0;
        
        NSString* mensaje = [NSString stringWithFormat:@"Tu mascota a subido es ahora nivel %d!",self.nivel];
        
        [[[UIAlertView alloc] initWithTitle:@"Felicitaciones!" message:mensaje delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

@end
