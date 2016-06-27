//
//  DetalhesViewController.m
//  MyVisitWold
//
//  Created by Carlos on 15/06/16.
//  Copyright © 2016 Carlos. All rights reserved.
//

#import "DetalhesViewController.h"

@interface DetalhesViewController ()

@end
BOOL camposValidos;
@implementation DetalhesViewController
@synthesize pais, lbCodTel, lbLongname, lbShortname, imgBandeira, txtData, scrollView, arrayPais, datePicker, viewData, switchOnOFF;


- (void)viewDidLoad {
    [super viewDidLoad];
    //seta imagem de fundo na tela
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    // Do any additional setup after loading the view.
    [viewData setHidden:YES];
    
    //Seta as infomações
    lbShortname.text = pais.shortname;
    lbLongname.text = pais.longname;
    UIImage *image = [UIImage imageWithData: pais.bandeira];
    imgBandeira.image =image;
    lbCodTel.text = [NSString stringWithFormat:@"Código Telefone: %@", pais.callingCode];
    txtData.text = pais.date;
    if([pais.visitado isEqualToString:@"true"]){
        [switchOnOFF setOn:YES];    }
    //Inicializa Scroll
    [self.scrollView setScrollEnabled:YES];
    self.scrollView.contentSize =CGSizeMake(0, 400);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * Salva visita e direciona para a tela que lista todos os países
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
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
                
               [self.navigationController popToRootViewControllerAnimated:YES];
                
                break;
            }
        }
    }
    [Funcionalidades stopProgressBar:self.view];
}
/**
 * Delegate do textField, inicializa quando usuário toca no campo de texto
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [viewData setHidden:NO];
    [self.view endEditing:YES];
}
/**
 * Valida campos: País marcado e data de visita
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
-(BOOL) validaCamposObrigatorios {
    
    NSMutableString *camposObrigatorios = [[NSMutableString alloc] initWithString:@""];
    BOOL camposValidos = YES;
    
    if(![switchOnOFF isOn]) {
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
/**
 * Seta a data selecionada no UITextField
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
- (IBAction)btDefinirData:(id)sender {
    dataDefinir =[datePicker date];
    [viewData setHidden:YES];
    
    //converte date para string e seta no textField
    [txtData setText:[Funcionalidades converteDataLocalString:dataDefinir]];
    
    
}

@end
