//
//  PerfilViewController.h
//  MyVisitWorld
//
//  Created by Carlos on 15/06/16.
//  Copyright © 2016 Carlos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Perfil.h"
#import "ModeloPerfil.h"

@interface PerfilViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgPerfil;
@property (weak, nonatomic) IBOutlet UILabel *lbNome;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
- (IBAction)btn:(id)sender;

@end
