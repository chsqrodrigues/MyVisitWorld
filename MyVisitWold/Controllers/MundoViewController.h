//
//  MundoViewController.h
//  MyVisitWold
//
//  Created by Carlos on 14/06/16.
//  Copyright © 2016 Carlos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Funcionalidades.h"
#import "DetalhesViewController.h"
#import "Pais.h"
#import "ModeloPais.h"
#import "ViewController.h"


@interface MundoViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, NSURLSessionDataDelegate>{
    NSArray * paisArray;
    NSMutableArray*arrayImage;
    NSMutableArray*arrayShortName;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UILabel *lbNome;
- (IBAction)btSair:(id)sender;


@end
