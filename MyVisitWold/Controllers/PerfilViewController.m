//
//  PerfilViewController.m
//  MyVisitWorld
//
//  Created by Carlos on 15/06/16.
//  Copyright © 2016 Carlos. All rights reserved.
//

#import "PerfilViewController.h"

@interface PerfilViewController ()


@end

@implementation PerfilViewController
@synthesize lbNome, lbEmail, imgPerfil;

- (void)viewDidLoad {
    [super viewDidLoad];
   //seta imagem de fundo na tela
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    
    NSArray *arrayPerfil = [[NSArray alloc]init];
    arrayPerfil =  [[ModeloPerfil modeloCompartilhado] itens];
    //Seta infomações(nome e email) do Facebook
    for(Perfil *elemento in arrayPerfil){
        lbNome.text = elemento.nome;
        lbEmail.text = elemento.email;
        UIImage *image = [UIImage imageWithData: elemento.foto];
        imgPerfil.image =image;
        break;
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btn:(id)sender {
    
    
}
@end
