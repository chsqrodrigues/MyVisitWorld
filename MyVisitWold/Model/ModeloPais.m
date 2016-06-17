//
//  ModeloPais.m
//  MyVisitWold
//
//  Created by Carlos on 15/06/16.
//  Copyright © 2016 Carlos. All rights reserved.
//

#import "ModeloPais.h"

@implementation ModeloPais
+ (ModeloPais *)modeloCompartilhado
{
    static ModeloPais *modeloCompartilhado = nil;
    
    if (!modeloCompartilhado) {
        modeloCompartilhado = [[super allocWithZone:nil] init];
    }
    
    return modeloCompartilhado;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self modeloCompartilhado];
}

- (id)init
{
    if (self = [super init]) {
        modelo = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:modelo];
        NSURL *urlDeArmazenamento = [NSURL fileURLWithPath: [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent: @"Pais.sqlite"]];
        
        NSError *erro = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:urlDeArmazenamento
                                     options:nil
                                       error:&erro]) {
            [NSException raise:@"Falha na abertura do arquivo" format:@"Motivo %@", [erro localizedDescription]];
        }
        
        contexto = [[NSManagedObjectContext alloc] init];
        [contexto setPersistentStoreCoordinator:psc];
        
        [self carregarTodosOsItens];
    }
    
    return self;
}

- (NSArray *)itens
{
    return itens;
}

- (Pais *)criarItem
{
    Pais *atividade = [NSEntityDescription insertNewObjectForEntityForName:@"Pais" inManagedObjectContext:contexto];
    [itens addObject:atividade];
    
    return atividade;
}

- (void)removerItem:(NSString *)item
{
    [itens removeObjectIdenticalTo:item];
}

- (void)excluirItem:(Pais *)atividade
{
    [contexto deleteObject:atividade];
    [itens removeObjectIdenticalTo:atividade];
}

- (void)excluirTodosOsItens
{
    NSFetchRequest * allAtividades = [[NSFetchRequest alloc] init];
    [allAtividades setEntity:[NSEntityDescription entityForName:@"Pais"
                                         inManagedObjectContext:contexto]];
    [allAtividades setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * atividades = [contexto executeFetchRequest:allAtividades error:&error];
    
    for (NSManagedObject * atividade in atividades) {
        [contexto deleteObject:atividade];
    }
    NSError *saveError = nil;
    [contexto save:&saveError];
    
    [self salvarMudancas];
    
}


- (void)carregarTodosOsItens
{
    if (!itens) {
        NSFetchRequest *requisicao = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entidade = [[modelo entitiesByName] objectForKey:@"Pais"];
        [requisicao setEntity:entidade];
        
        NSSortDescriptor *descritorDeOrdenacao = [NSSortDescriptor sortDescriptorWithKey:@"idPais" ascending:YES];
        [requisicao setSortDescriptors:[NSArray arrayWithObject:descritorDeOrdenacao]];
        
        NSError *erro;
        NSArray *resultado = [contexto executeFetchRequest:requisicao error:&erro];
        
        if (!resultado) {
            [NSException raise:@"Falha na consulta (fetch)" format:@"Motivo: %@", [erro localizedDescription]];
        }
        itens = [[NSMutableArray alloc] initWithArray:resultado];
    }
}

- (BOOL)salvarMudancas
{
    NSError *erro;
    BOOL gravouCorretamente;
    
    gravouCorretamente = [contexto save:&erro];
    
    if (!gravouCorretamente) {
        NSLog(@"Falha ao salvar os objetos: %@", [erro localizedDescription]);
    }
    
    itens = nil;
    [self carregarTodosOsItens];
    
    return gravouCorretamente;
}




@end
