//
//  StatusViewController.m
//  ZooAcamica
//
//  Created by Matias Paillet on 11/13/13.
//  Copyright (c) 2013 Nicolás Porpiglia. All rights reserved.
//

#import "StatusViewController.h"
#import "EstadoMascota.h"

@interface StatusViewController ()

@end

@implementation StatusViewController

- (NSString*) title {
    return @"Estado";
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [progressEnergia setProgress:[[EstadoMascota sharedInstance] energia]/100 animated:YES];
    [lblExperiencia setText:[NSString stringWithFormat:@"Experiencia: %d", [[EstadoMascota sharedInstance] experiencia]]];
    [lblNivel setText:[NSString stringWithFormat:@"Nivel: %d", [[EstadoMascota sharedInstance] nivel]]];
    [txtNombre setText:[[EstadoMascota sharedInstance] nombre]];

}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    [[EstadoMascota sharedInstance] setNombre:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
