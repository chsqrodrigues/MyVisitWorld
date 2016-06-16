//
//  MundoViewController.m
//  MyVisitWold
//
//  Created by Etica on 14/06/16.
//  Copyright © 2016 Etica. All rights reserved.
//

#import "MundoViewController.h"

@implementation MundoViewController
@synthesize lbNome, collection;
- (void)viewDidLoad {
    [self.view endEditing:YES];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    // Do any additional setup after loading the view, typically from a nib.
    paisArray = [[NSMutableArray alloc]init];
    paisArray =  [[ModeloPais modeloCompartilhado] itens];
    
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
            NSString *urlString = [NSString stringWithFormat:@"http://mypushapi-dev.us-east-1.elasticbeanstalk.com/world/countries/%@/flag", paisAtual.idPais];
            NSURL *imageURL = [NSURL URLWithString:urlString];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            [paisAtual setBandeira:imageData];
            [[ModeloPais modeloCompartilhado] salvarMudancas];
            
            
            //  UIImage *image = [UIImage imageWithData:imageData];
            
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Pais *paisTab = [paisArray objectAtIndex:indexPath.row];
    
    DetalhesViewController *detalhes = [self.storyboard instantiateViewControllerWithIdentifier:@"DetalhesViewController"];
    
    detalhes.pais = paisTab;
    detalhes.arrayPais = paisArray;
    
    [self presentViewController:detalhes animated:YES completion:nil];
    
    
}
- (IBAction)btSair:(id)sender {
    ViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    [self presentViewController:login animated:YES completion:nil];
    
    
}
@end







