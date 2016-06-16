//
//  DetalhesViewController.h
//  MyVisitWold
//
//  Created by Etica on 15/06/16.
//  Copyright © 2016 Etica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pais.h"
#import "ModeloPais.h"
#import "Funcionalidades.h"
#import "MundoViewController.h"

@interface DetalhesViewController : UIViewController{
    NSDate *dataDefinir ;
    int  validaTipoData;
    
    
}

@property (weak, nonatomic)  Pais *pais;
@property (weak, nonatomic)  NSArray *arrayPais;
@property (weak, nonatomic) IBOutlet UILabel *lbShortname;
@property (weak, nonatomic) IBOutlet UILabel *lbLongname;
@property (weak, nonatomic) IBOutlet UIImageView *imgBandeira;
@property (weak, nonatomic) IBOutlet UILabel *lbCodTel;
@property (weak, nonatomic) IBOutlet UIButton *btCheck;
- (IBAction)btCheck:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtData;
- (IBAction)btConfirmar:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewData;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)btCancelar:(id)sender;

- (IBAction)btDefinirData:(id)sender;


@end
