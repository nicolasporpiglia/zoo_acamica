//
//  StatusViewController.h
//  ZooAcamica
//
//  Created by Matias Paillet on 11/13/13.
//  Copyright (c) 2013 Nicolás Porpiglia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusViewController : UIViewController <UITextFieldDelegate>{
    IBOutlet UIProgressView* progressEnergia;
    IBOutlet UILabel *lblExperiencia, *lblNivel;
    IBOutlet UITextField *txtNombre;
}

@end
