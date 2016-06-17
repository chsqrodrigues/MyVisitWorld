//
//  ModeloPais.h
//  MyVisitWold
//
//  Created by Carlos on 15/06/16.
//  Copyright © 2016 Carlos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Pais.h"

@interface ModeloPais : NSObject{
    NSMutableArray          *itens;
    NSManagedObjectContext  *contexto;
    NSManagedObjectModel    *modelo;

}

+ (ModeloPais *)modeloCompartilhado;

- (NSArray *)itens;
- (BOOL)salvarMudancas;
- (Pais *)criarItem;
- (void)excluirItem:(Pais *)produto;
- (void)excluirTodosOsItens;

@end
