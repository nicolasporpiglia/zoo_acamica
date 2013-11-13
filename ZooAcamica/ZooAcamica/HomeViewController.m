//
//  HomeViewController.m
//  ZooAcamica
//
//  Created by Matias Paillet on 11/3/13.
//  Copyright (c) 2013 Nicolás Porpiglia. All rights reserved.
//

#import "HomeViewController.h"
#import "EstadoMascota.h"

@implementation HomeViewController

- (void) viewWillAppear:(BOOL)animated {
    
    UIBarButtonItem *comidasButton = [[UIBarButtonItem alloc] initWithTitle:@"Comidas" style:UIBarButtonItemStylePlain target:self action:@selector(openComidas)];
    
    NSArray *actionButtonItems = @[comidasButton];
    
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    [self actualizarEnergia];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mascotaExtenuada) name:NOTIFICACION_MASCOTA_SIN_ENERGIA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mascotaTieneEnergiaOtraVez) name:NOTIFICACION_MASCOTA_CON_ENERGIA object:nil];
}

- (void) viewWillDisappear:(BOOL)animated {
    [self pararEjercicio];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICACION_MASCOTA_CON_ENERGIA object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICACION_MASCOTA_SIN_ENERGIA object:nil];
}

- (NSString*) title {
    return @"Panchito";
}

- (void) openComidas {
    ComidasViewController* comidasController = [[ComidasViewController alloc] initWithNibName:@"ComidasViewController" bundle:nil];
    [comidasController setDelegate:self];
    [self.navigationController pushViewController:comidasController animated:YES];
}

- (IBAction) screenTapped:(UITapGestureRecognizer*)sender {
    CGPoint tappedPoint = [sender locationInView:self.view];
    CGFloat xCoordinate = tappedPoint.x;
    CGFloat yCoordinate = tappedPoint.y;
    
    [UIView animateWithDuration:1.0f
                     animations:^(void) {
                         [imagenComida setFrame:CGRectMake(xCoordinate - imagenComida.frame.size.width / 2,
                                                           yCoordinate - imagenComida.frame.size.height /2 ,
                                                           90,
                                                           90)];
                     } completion:^(BOOL finished) {
                         if([self tapEnMascota:tappedPoint]) {
                             [imagenComida removeFromSuperview];
                             AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                             
                             [[EstadoMascota sharedInstance] ingirioComida];
                             [self actualizarEnergia];
                             
                             NSArray * imagenesMascotaComiendo  = [[NSArray alloc] initWithObjects:
                                                      [UIImage imageNamed:@"comiendo_1.png"],
                                                      [UIImage imageNamed:@"comiendo_2.png"],
                                                      [UIImage imageNamed:@"comiendo_3.png"],
                                                      nil];
                             [imgMascota setAnimationImages:imagenesMascotaComiendo];
                             [imgMascota setAnimationDuration:1.0f];
                             [imgMascota setAnimationRepeatCount:3.0f];
                             [imgMascota startAnimating];
                         }
                     }];
}

- (BOOL) tapEnMascota:(CGPoint) point {
    
    BOOL xIsInside = point.x > imgMascota.frame.origin.x && point.x < (imgMascota.frame.origin.x + imgMascota.frame.size.width);
    BOOL yIsInside = point.y > imgMascota.frame.origin.y && point.y < (imgMascota.frame.origin.y + imgMascota.frame.size.height);
    
    return xIsInside && yIsInside;
}

- (void) didSelectedComida:(NSString *)comidaImage {
    UIImage* img = [UIImage imageNamed:comidaImage];
    imagenComida = [[UIImageView alloc] initWithImage:img];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    [imagenComida setFrame:CGRectMake(screenWidth - 90, screenHeight - 90, 90, 90)];
    
    [self.view addSubview:imagenComida];
}

- (IBAction) hacerEjercicio:(id)sender {
    
    if(!self.estaEjercitando) {
        [self iniciarEjercicio];
    } else {
        [self pararEjercicio];
    }
}

- (void) iniciarEjercicio {
    NSArray * imagenesMascotaEjercitando  = [[NSArray alloc] initWithObjects:
                                             [UIImage imageNamed:@"ejercitando_1.png"],
                                             [UIImage imageNamed:@"ejercitando_2.png"],
                                             [UIImage imageNamed:@"ejercitando_3.png"],
                                             nil];
    [imgMascota setAnimationImages:imagenesMascotaEjercitando];
    [imgMascota setAnimationDuration:1.0f];
    [imgMascota startAnimating];
    
    [btnEjercitar setTitle:@"Parar" forState:UIControlStateNormal];
    
    timerEjercicio = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(haciendoEjercicio) userInfo:nil repeats:YES];
    
    self.estaEjercitando = YES;
}

- (void) pararEjercicio {
    [imgMascota stopAnimating];
    
    [timerEjercicio invalidate];
    timerEjercicio = nil;
    
    [btnEjercitar setTitle:@"Ejercitar" forState:UIControlStateNormal];
    
    self.estaEjercitando = NO;
}

- (void) haciendoEjercicio {
    [[EstadoMascota sharedInstance] ejercitar];
    [self actualizarEnergia];
}

- (void) actualizarEnergia {
    [progressEnergia setProgress:[[EstadoMascota sharedInstance] energia]/100 animated:YES];
}

- (void) mascotaExtenuada {
    
    [[[UIAlertView alloc] initWithTitle:@"Tu mascota esta extenuada!" message:@"Dale de comer para que recupere energía" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    
    [self pararEjercicio];
    
    [imgMascota setImage:[UIImage imageNamed:@"mascota_extenuda.png"]];
    
    [btnEjercitar setEnabled:NO];
}

- (void) mascotaTieneEnergiaOtraVez {
    [imgMascota setImage:[UIImage imageNamed:@"mascota_normal.png"]];
    
    [btnEjercitar setEnabled:YES];
}

@end
