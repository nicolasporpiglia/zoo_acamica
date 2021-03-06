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


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self){
        [[EstadoMascota sharedInstance] setNombre:@"Panchito"];
    }
    
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    
    UIBarButtonItem *comidasButton = [[UIBarButtonItem alloc] initWithTitle:@"Comidas" style:UIBarButtonItemStylePlain target:self action:@selector(openComidas)];
    
    NSArray *actionButtonItems = @[comidasButton];
    
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    [self actualizarEnergia];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mascotaExtenuada) name:NOTIFICACION_MASCOTA_SIN_ENERGIA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mascotaTieneEnergiaOtraVez) name:NOTIFICACION_MASCOTA_CON_ENERGIA object:nil];
    
    self.title = [[EstadoMascota sharedInstance] nombre];
}

- (void) viewWillDisappear:(BOOL)animated {
    [self pararEjercicio];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICACION_MASCOTA_CON_ENERGIA object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICACION_MASCOTA_SIN_ENERGIA object:nil];
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
                                                           55,
                                                           55)];
                     } completion:^(BOOL finished) {
                         if([self tapEnMascota:tappedPoint] && imagenComida) {
                             
                             [imagenComida removeFromSuperview];
                             imagenComida = nil;
                             AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                             
                             [[EstadoMascota sharedInstance] ingirioComida];
                             [self actualizarEnergia];
                             
                             NSArray * imagenesMascotaComiendo  = [[NSArray alloc] initWithObjects:
                                                      [UIImage imageNamed:@"comiendo_1.png"],
                                                      [UIImage imageNamed:@"comiendo_2.png"],
                                                      [UIImage imageNamed:@"comiendo_3.png"],
                                                      [UIImage imageNamed:@"comiendo_3.png"],
                                                      nil];
                             [imgMascota setAnimationImages:imagenesMascotaComiendo];
                             [imgMascota setAnimationDuration:1.0f];
                             [imgMascota setAnimationRepeatCount:1.0f];
                             [imgMascota startAnimating];
                         }
                     }];
}

- (BOOL) tapEnMascota:(CGPoint) point {
    
    BOOL xIsInside = point.x > viewZonaComer.frame.origin.x && point.x < (viewZonaComer.frame.origin.x + viewZonaComer.frame.size.width);
    BOOL yIsInside = point.y > viewZonaComer.frame.origin.y && point.y < (viewZonaComer.frame.origin.y + viewZonaComer.frame.size.height);
    
    return xIsInside && yIsInside;
}

- (void) didSelectedComida:(NSString *)comidaImage {
    
    if (imagenComida){
        [imagenComida removeFromSuperview];
        imagenComida = nil;
    }
    
    UIImage* img = [UIImage imageNamed:comidaImage];
    imagenComida = [[UIImageView alloc] initWithImage:img];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    [imagenComida setFrame:CGRectMake(screenWidth - 90, screenHeight - 150, 55, 55)];
    
    [self.view addSubview:imagenComida];
    
    [self.navigationController popToViewController:self animated:YES];
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
                                             [UIImage imageNamed:@"ejercicio_1.png"],
                                             [UIImage imageNamed:@"ejercicio_2.png"],
                                             [UIImage imageNamed:@"ejercicio_3.png"],
                                             [UIImage imageNamed:@"ejercicio_4.png"],
                                             [UIImage imageNamed:@"ejercicio_5.png"],
                                             nil];
    [imgMascota setAnimationImages:imagenesMascotaEjercitando];
    [imgMascota setAnimationDuration:0.6f];
    [imgMascota setAnimationRepeatCount:0];
    [imgMascota startAnimating];
    
    [btnEjercitar setTitle:@"PARAR" forState:UIControlStateNormal];
    
    timerEjercicio = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(haciendoEjercicio) userInfo:nil repeats:YES];
    
    self.estaEjercitando = YES;
}

- (void) pararEjercicio {
    [imgMascota stopAnimating];
    
    [timerEjercicio invalidate];
    timerEjercicio = nil;
    
    [btnEjercitar setTitle:@"EJERCITAR" forState:UIControlStateNormal];
    
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

    [self pararEjercicio];
    
    NSArray * imagenesMascotaExhausto  = [[NSArray alloc] initWithObjects:
                                          [UIImage imageNamed:@"exhausto_1.png"],
                                          [UIImage imageNamed:@"exhausto_2.png"],
                                          [UIImage imageNamed:@"exhausto_3.png"],
                                          nil];
    [imgMascota setAnimationImages:imagenesMascotaExhausto];
    [imgMascota setAnimationDuration:0.6f];
    [imgMascota setAnimationRepeatCount:1.0f];
    [imgMascota startAnimating];
    [imgMascota performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"exhausto_4.png"] afterDelay:0.7f];

    
    [btnEjercitar setEnabled:NO];
}

- (void) mascotaTieneEnergiaOtraVez {
    
    [imgMascota setImage:[UIImage imageNamed:@"ejercicio_1"]];
    
    [btnEjercitar setEnabled:YES];
}

@end
