//
//  VisitadosViewController.m
//  MyVisitWold
//
//  Created by Etica on 14/06/16.
//  Copyright © 2016 Etica. All rights reserved.
//

#import "VisitadosViewController.h"

@implementation VisitadosViewController
@synthesize table;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    
    pais = [[NSArray alloc]init];
    paisArray = [[NSMutableArray alloc]init];
    pais =  [[ModeloPais modeloCompartilhado] itens];
    
    for(Pais *elemento in pais){
        if([elemento.visitado isEqualToString:@"true"]){
            [paisArray addObject:elemento];
        }
    }
    self.table.allowsMultipleSelectionDuringEditing = NO;
    
    [table reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [paisArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier;
    UITableViewCell *cell;
    
    cellIdentifier = @"myCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
        
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    Pais *paisCell = nil;
    
    paisCell =[paisArray objectAtIndex:indexPath.row];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:10];
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    UIButton *button = (UIButton *) [cell viewWithTag:35];
    
    [button addTarget:self action:@selector(excluir:)   forControlEvents:UIControlEventTouchDown];
    
    if ([paisCell.selected isEqualToString:@"true"]) {
        UIImage *btnImage = [UIImage imageNamed:@"check_box.png"];
        [button setImage:btnImage forState:UIControlStateNormal];
    }else{
        UIImage *btnImage = [UIImage imageNamed:@"ico_cxcheck.png"];
        [button setImage:btnImage forState:UIControlStateNormal];
        
    }
    
    label.text = paisCell.shortname;
    
    UIImage *image = [UIImage imageWithData: paisCell.bandeira];
    recipeImageView.image =image;
    
    
    
    
    return cell;
    
}
-(void)excluir:(UIButton*)btn

{
    
    CGPoint buttonPosition = [btn convertPoint:CGPointZero toView:table];
    NSIndexPath *indexPath = [table indexPathForRowAtPoint:buttonPosition];
    Pais *paisModelo = nil;
    paisModelo = [paisArray objectAtIndex:indexPath.row];
    
    
    for(Pais *elementoPais in paisArray){
        if([elementoPais.idPais isEqualToString:paisModelo.idPais]){
            if ([ elementoPais.selected isEqualToString:@"false"]) {
                
                [elementoPais setSelected:@"true"];
            }
            
            else if ([ elementoPais.selected isEqualToString:@"true"]) {
                
                [elementoPais setSelected:@"false"];
            }
            
        }
        
    }
    [[ModeloPais modeloCompartilhado] salvarMudancas];
    
    [table reloadData];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[self table] setEditing:![[self table] isEditing]animated:YES];
        
        Pais *paisTab = [paisArray objectAtIndex:indexPath.row];
        for(Pais *elemento in paisArray){
            if([paisTab.idPais isEqualToString:elemento.idPais]){
                [paisTab setDate:nil];
                [paisTab setVisitado:nil];
                [paisTab setSelected:@"false"];
                [[ModeloPais modeloCompartilhado] salvarMudancas];
                break;
            }
        }
        
        
        pais = [[NSArray alloc]init];
        paisArray = [[NSMutableArray alloc]init];
        pais =  [[ModeloPais modeloCompartilhado] itens];
        
        for(Pais *elemento in pais){
            if([elemento.visitado isEqualToString:@"true"]){
                [paisArray addObject:elemento];
            }
        }
        
        [table reloadData];
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Pais *paisTab = [paisArray objectAtIndex:indexPath.row];
    
    DetalhesViewController *detalhes = [self.storyboard instantiateViewControllerWithIdentifier:@"DetalhesViewController"];
    
    detalhes.pais = paisTab;
    detalhes.arrayPais = paisArray;
    
    [self presentViewController:detalhes animated:YES completion:nil];
    
    
    
}
- (IBAction)btExcluir:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção!"
                                                    message:@"Deseja excluir todos os itens selecionados?"
                                                   delegate:self
                                          cancelButtonTitle:@"Não"
                                          otherButtonTitles:@"Sim", nil];
    [alert show];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex]) {
        pais =  [[ModeloPais modeloCompartilhado] itens];
        for(Pais *elementoPais in pais){
            
            if ([ elementoPais.selected isEqualToString:@"true"]) {
                [elementoPais setDate:nil];
                [elementoPais setVisitado:nil];
                [elementoPais setSelected:@"false"];
            }
        }
        
        pais = [[NSArray alloc]init];
        paisArray = [[NSMutableArray alloc]init];
        pais =  [[ModeloPais modeloCompartilhado] itens];
        
        for(Pais *elemento in pais){
            if([elemento.visitado isEqualToString:@"true"]){
                [paisArray addObject:elemento];
            }
        }
        
        [table reloadData];
        
    }
}
@end