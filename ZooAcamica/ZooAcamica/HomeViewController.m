//
//  HomeViewController.m
//  ZooAcamica
//
//  Created by Matias Paillet on 11/3/13.
//  Copyright (c) 2013 Nicolás Porpiglia. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [nombre setText:@"Panchito"];
}

- (void) viewWillAppear:(BOOL)animated {
    
    UIBarButtonItem *comidasButton = [[UIBarButtonItem alloc] initWithTitle:@"Comidas" style:UIBarButtonItemStylePlain target:self action:@selector(openComidas)];
    
    NSArray *actionButtonItems = @[comidasButton];
    
    self.navigationItem.rightBarButtonItems = actionButtonItems;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*) title {
    return @"Mi Mascota";
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
                         }
                     }];
}

- (BOOL) tapEnMascota:(CGPoint) point {
    
    BOOL xIsInside = point.x > imagenComida.frame.origin.x && point.x < (imagenComida.frame.origin.x + imagenComida.frame.size.width);
    BOOL yIsInside = point.y > imagenComida.frame.origin.y && point.y < (imagenComida.frame.origin.y + imagenComida.frame.size.height);
    
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

@end
