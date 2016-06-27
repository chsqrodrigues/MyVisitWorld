//
//  VisitadosViewController.m
//  MyVisitWold
//
//  Created by Carlos on 14/06/16.
//  Copyright © 2016 Carlos. All rights reserved.
//

#import "VisitadosViewController.h"

@implementation VisitadosViewController
@synthesize table;
- (void)viewDidLoad {
    [super viewDidLoad];
    // seta imagem de fundo
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    
    [self atualizaTable];
       self.table.allowsMultipleSelectionDuringEditing = NO;
    [table reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self atualizaTable];
    [table reloadData];
    // Reload your data here, and this gets called
    // before the view transition is complete.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)atualizaTable{
    pais = [[NSArray alloc]init];
    paisArray = [[NSMutableArray alloc]init];
    pais =  [[ModeloPais modeloCompartilhado] itens];
    
    //Verifica paises visitados
    for(Pais *elemento in pais){
        if([elemento.visitado isEqualToString:@"true"]){
            [paisArray addObject:elemento];
        }
    }


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [paisArray count];
}
/**
 * UITableView recebe imagem da bandeira do país, shortname
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
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
    
    //Marca ou desmarca país
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
/**
 * Métado que recebe ação, marcando ou desmarcando país para excluir da lista
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
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
    return YES;
}
/**
 * Esse métado que recebe gesto e exclui item da tabela. Salva as mudanças e recarrega tabela
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
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
/**
 * Métado que recebe toque da célula, e direciona para a tela de detalhes e passa o país selecionado
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
  
    NSIndexPath *indexPathImInterestedIn = [self.table indexPathForSelectedRow];
    Pais *paisTab = [paisArray objectAtIndex:indexPathImInterestedIn.item];
    
    
    
    DetalhesViewController *destViewController = segue.destinationViewController;
    destViewController.pais = paisTab;
    destViewController.arrayPais = paisArray;
    
}

/**
 * Exibe alerta de confirmação
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
- (IBAction)btExcluir:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção!"
                                                    message:@"Deseja excluir todos os itens selecionados?"
                                                   delegate:self
                                          cancelButtonTitle:@"Não"
                                          otherButtonTitles:@"Sim", nil];
    [alert show];
}
/**
 * Esse métado recebe ação do botão sim do UIAlert. Exclui itens selecionados e recarrega tabela
 * @author Carlos (ch.sqrodrigues@gmail.com)
 */
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
