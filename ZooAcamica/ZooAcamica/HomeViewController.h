//
//  HomeViewController.h
//  ZooAcamica
//
//  Created by Matias Paillet on 11/3/13.
//  Copyright (c) 2013 Nicolás Porpiglia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ComidasViewController.h"

@interface HomeViewController : UIViewController<ComidasSelected>{
    
    IBOutlet UIImageView* imgMascota;
    IBOutlet UIButton* btnEjercitar;
    IBOutlet UIProgressView* progressEnergia;
    
    UIImageView* imagenComida;
    NSTimer* timerEjercicio;
}

@property(nonatomic,assign) BOOL estaEjercitando;

@end
