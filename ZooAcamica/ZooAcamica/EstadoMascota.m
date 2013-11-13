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

- (void) ingirioComida {
    self.energia += 50;
    
    if(self.energia > 100) {
        self.energia = 100;
    }
}

- (void) ejercitar {
    self.energia--;
    
    if (self.energia < 0) {
      self.energia = 0;
    }
}

@end
