//
//  MundoViewController.m
//  MyVisitWold
//
//  Created by Carlos on 14/06/16.
//  Copyright © 2016 Carlos. All rights reserved.
//

#import "MundoViewController.h"

@implementation MundoViewController
@synthesize lbNome, collection;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view endEditing:YES];
    
    //seta imagem de fundo na tela
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    paisArray = [[NSMutableArray alloc]init];
    paisArray =  [[ModeloPais modeloCompartilhado] itens];
    //Valida necessidade de requisição
    if([paisArray count]==0){
        [self requestListaPaises];
        
    }
   
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [collection reloadData];
    // Reload your data here, and this gets called
    // before the view transition is complete.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    // Reload your data here, and this gets called
    // after the view transition is complete.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 * Realiza requisição e salva informações no banco de dados
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
-(void)requestListaPaises{
    [Funcionalidades startProgressBar:self.view];
    
    
    NSURLRequest *requestLogin = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mypushapi-dev.us-east-1.elasticbeanstalk.com/world/countries/active"]];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration: sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    
    [[session dataTaskWithRequest:requestLogin completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        for(NSDictionary *elemento in greeting){
            
            Pais *paisAtual = [[ModeloPais  modeloCompartilhado] criarItem];
            [paisAtual setIdPais: [NSString stringWithFormat:@"%@",[elemento valueForKey:@"id"]]];
            [paisAtual setShortname:[elemento valueForKey:@"shortname"]];
            [paisAtual setIso:[elemento valueForKey:@"iso"]];
            [paisAtual setLongname:[elemento valueForKey:@"longname"]];
            [paisAtual setCallingCode:[NSString stringWithFormat:@"%@",[elemento valueForKey:@"callingCode"]]];
            [paisAtual setStatus:[NSString stringWithFormat:@"%@",[elemento valueForKey:@"status"]]];
            [paisAtual setCulture:[elemento valueForKey:@"culture"]];
            [paisAtual setSelected:@"false"];
            
            //Seta imagem da bandeira do país
            NSString *urlString = [NSString stringWithFormat:@"http://mypushapi-dev.us-east-1.elasticbeanstalk.com/world/countries/%@/flag", paisAtual.idPais];
            NSURL *imageURL = [NSURL URLWithString:urlString];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            [paisAtual setBandeira:imageData];
            [[ModeloPais modeloCompartilhado] salvarMudancas];
            
            
        }
        paisArray = [[NSMutableArray alloc]init];
        paisArray =  [[ModeloPais modeloCompartilhado] itens];
        
        [collection reloadData];
        [Funcionalidades stopProgressBar:self.view];
        
        
    }]resume];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return paisArray.count;
}
/**
 * Coleção recebe imagem da bandeira do país, shortname e se tiver sido visitado recebe check
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"myCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:50];
    UIImageView *check = (UIImageView *)[cell viewWithTag:75];
    
    Pais * paisCell=nil;
    paisCell =[paisArray objectAtIndex:indexPath.row];
    label.text = paisCell.shortname;
    UIImage *image = [UIImage imageWithData: paisCell.bandeira];
    recipeImageView.image =image;
    
    if([paisCell.visitado isEqualToString:@"true"]){
        check.hidden = NO;
        
    }else{
        check.hidden = YES;
    }
    return cell;
}
/**
 * Métado que recebe toque da célula, e direciona para a tela de detalhes e passa o país selecionado
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
  
    
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //NSIndexPath *indexPath = [self.collection indexPathsForSelectedItems];
    
    
    
    
    
    NSArray *arrayOfIndexPaths = [self.collection indexPathsForSelectedItems];
    NSIndexPath *indexPathImInterestedIn = [arrayOfIndexPaths firstObject];
    Pais *paisTab = [paisArray objectAtIndex:indexPathImInterestedIn.item];

   
       
        DetalhesViewController *destViewController = segue.destinationViewController;
        destViewController.pais = paisTab;
        destViewController.arrayPais = paisArray;
    
}
/**
 * Esta ação direciona o usúario para a tela inicial do APP
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
- (IBAction)btSair:(id)sender {
    ViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    [self presentViewController:login animated:YES completion:nil];
    
}
@end







