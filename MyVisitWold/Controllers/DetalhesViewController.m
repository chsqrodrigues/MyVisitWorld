//
//  DetalhesViewController.m
//  MyVisitWold
//
//  Created by Etica on 15/06/16.
//  Copyright © 2016 Etica. All rights reserved.
//

#import "DetalhesViewController.h"

@interface DetalhesViewController ()

@end
BOOL camposValidos;
@implementation DetalhesViewController
@synthesize pais, lbCodTel, lbLongname, lbShortname, imgBandeira, btCheck, txtData, scrollView, arrayPais, datePicker, viewData;

/**
 * Meto que inicializa toque na tela.
 */
-(void) inicializaGesto {
    UIGestureRecognizer *gesto  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickForaTeclado:)];
    gesto.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gesto];
}

/**
 *  Se tocar em qualquer 'ponto' fora do teclado esconde o teclado.
 */
-(IBAction)clickForaTeclado :(id)sender {
    [self.view endEditing:YES];
    [self ajustaScrollViewPosicaoY:scrollView ePosicaoY:( 0)];
    
}
-(void) ajustaScrollViewPosicaoY: (UIScrollView *) scrollViewElemento  ePosicaoY: (int) posicaoY {
    [scrollViewElemento setContentOffset: CGPointMake(0, posicaoY) animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self inicializaGesto];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    // Do any additional setup after loading the view.
    [viewData setHidden:YES];
    
    lbShortname.text = pais.shortname;
    lbLongname.text = pais.longname;
    UIImage *image = [UIImage imageWithData: pais.bandeira];
    imgBandeira.image =image;
    lbCodTel.text = pais.callingCode;
    txtData.text = pais.date;
    if([pais.visitado isEqualToString:@"true"]){
        [btCheck setImage:[UIImage imageNamed:@"iconTrue.png"] forState:UIControlStateNormal];
        [btCheck setSelected:YES];
    }
    
    [self.scrollView setScrollEnabled:YES];
    self.scrollView.contentSize =CGSizeMake(0, 400);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btCheck:(id)sender {
    if ([btCheck isSelected]== NO){
        [btCheck setImage:[UIImage imageNamed:@"iconTrue.png"] forState:UIControlStateNormal];
        [btCheck setSelected:YES];
        
    }
    else {
        [btCheck setImage:[UIImage imageNamed:@"iconFalse.png"] forState:UIControlStateNormal];        [btCheck setSelected:NO];
        
    }
}
- (IBAction)btConfirmar:(id)sender {
    
    
    if([self validaCamposObrigatorios]){
        [Funcionalidades startProgressBar:self.view];
        for(Pais *elemento in arrayPais){
            if([pais.idPais isEqualToString:elemento.idPais]){
                [elemento setDate:txtData.text];
                [elemento setVisitado:@"true"];
                [[ModeloPais modeloCompartilhado] salvarMudancas];
                
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção!"
                                                                message:@"Visita salva com sucesso"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
                MundoViewController *detalhes = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
                
                
                [self presentViewController:detalhes animated:YES completion:nil];
                
                break;
            }
            
            
            
        }
        
    }
    [Funcionalidades stopProgressBar:self.view];
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [viewData setHidden:NO];
    [self.view endEditing:YES];
    
}
-(BOOL) validaCamposObrigatorios {
    
    NSMutableString *camposObrigatorios = [[NSMutableString alloc] initWithString:@""];
    BOOL camposValidos = YES;
    
    if([btCheck isSelected]== NO ) {
        [camposObrigatorios
         appendString:@"- Marque o país como visitado.\n"];
        camposValidos = NO;
    }
    
    if([txtData.text length] ==0 ) {
        [camposObrigatorios
         appendString:@"- Infome a data que visitou o país.\n"];
        camposValidos = NO;
    }
    
    
    
    
    if(!camposValidos){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção!"
                                                        message:camposObrigatorios
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    return  camposValidos;
    
}
- (IBAction)btCancelar:(id)sender {
    [viewData setHidden:YES];
}

- (IBAction)btDefinirData:(id)sender {
    dataDefinir =[datePicker date];
    [viewData setHidden:YES];
    
    [txtData setText:[Funcionalidades converteDataLocalString:dataDefinir]];
    
    
}
@end
