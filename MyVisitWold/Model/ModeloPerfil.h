//
//  ModeloPerfil.h
//  MyVisitWorld
//
//  Created by Etica on 15/06/16.
//  Copyright © 2016 Etica. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Perfil.h"

@interface ModeloPerfil : NSObject{
    NSMutableArray          *itens;
    NSManagedObjectContext  *contexto;
    NSManagedObjectModel    *modelo;
    
}

+ (ModeloPerfil *)modeloCompartilhado;

- (NSArray *)itens;
- (BOOL)salvarMudancas;
- (Perfil *)criarItem;
- (void)excluirItem:(Perfil *)produto;
- (void)excluirTodosOsItens;

@end
