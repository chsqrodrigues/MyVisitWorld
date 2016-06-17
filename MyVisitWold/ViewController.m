//
//  ViewController.m
//  MyVisitWold
//
//  Created by Carlos on 14/06/16.
//  Copyright © 2016 Carlos. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Esté metado recebe as informações do Facebook e salva no banco Perfil
 O Facebook retorna as seguinter informações: Nome, Email, Imagem, id ;
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
-(void)cadastroFacebook{
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/me"
                                  parameters:@{ @"fields": @"name,email, picture",}
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if(result)
        {
            Perfil *perfil = [[ModeloPerfil  modeloCompartilhado] criarItem];
            if ([result objectForKey:@"id"]) {
                [perfil setIdFB:[result objectForKey:@"id"]];
                
            }
            if ([result objectForKey:@"email"]) {
                [perfil setNome:[result objectForKey:@"email"]];
                
            }
            if ([result objectForKey:@"name"]) {
                [perfil setEmail:[result objectForKey:@"name"]];
                
            }
            if ([result objectForKey:@"picture"]) {
                
                NSDictionary *dictionary = (NSDictionary *)result;
                NSDictionary *data = [dictionary objectForKey:@"picture"];
                NSDictionary *picture = [data objectForKey:@"data"];
                NSString *photoUrl = (NSString *)[picture objectForKey:@"url"];
                NSURL *imageURL = [NSURL URLWithString:photoUrl];
                NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                [perfil setFoto:imageData];
                
            }
            
            [[ModeloPerfil modeloCompartilhado] salvarMudancas];
            
        }
    }];
}
/**
 * Seta permissões do Facebook
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
- (IBAction)btFacebook:(id)sender {
    //Inicializa progress bar
    [Funcionalidades startProgressBar:self.view];
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    //Set Permissões
    [login logInWithReadPermissions:@[@"email", @"public_profile"] fromViewController:nil handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error)
        {
            //Em caso de erro exibe Alert
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção!"
                                                            message:@"Não foi possível obter informações do Facebook. Verifique e tente novamente."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [Funcionalidades stopProgressBar:self.view];
        }
        else
        {
            if(result.token)
            {
                //Se sucesso
                [self cadastroFacebook];
                MundoViewController *detalhes = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
                [self presentViewController:detalhes animated:YES completion:nil];
                [Funcionalidades stopProgressBar:self.view];
            }
            [Funcionalidades stopProgressBar:self.view];
        }
        
    }];
    
}

@end
