//
//  VisitadosViewController.h
//  MyVisitWold
//
//  Created by Etica on 14/06/16.
//  Copyright © 2016 Etica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModeloPais.h"
#import "Pais.h"
#import "DetalhesViewController.h"

@interface VisitadosViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *paisArray;
    NSArray *pais;
}
@property (weak, nonatomic) IBOutlet UITableView *table;
- (IBAction)btExcluir:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btExcluir;

@end
