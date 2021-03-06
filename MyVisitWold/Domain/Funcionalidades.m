//
//  Funcionalidades.m
//  MyVisitWold
//
//  Created by Carlos on 15/06/16.
//  Copyright © 2016 Carlos. All rights reserved.
//

#import "Funcionalidades.h"

@implementation Funcionalidades

/**
 * Inicializa o progress progressBar
 */
+(void)startProgressBar:(UIView*)view{
    
    UIView * viewNew  = [[UIView alloc]init];
    viewNew.tag  = 1;
    
    viewNew.frame =CGRectMake(round((view.frame.size.width - 120) / 2), round((view.frame.size.height - 120) / 2), 120, 120);

    
    UIActivityIndicatorView  *av = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] ;
    av.frame = CGRectMake(round((viewNew.frame.size.width - 25) / 2), round((viewNew.frame.size.height - 25) / 2), 25, 25);
    
    av.transform = CGAffineTransformMakeScale(2.5, 2.5);
    
    [viewNew addSubview:av];
    
    [view addSubview:viewNew];
    [av startAnimating];
    
    viewNew.layer.masksToBounds = YES;
    viewNew.layer.cornerRadius = 10;
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
}

/**
 * Finaliza o progress progressBar
 */
+(void)stopProgressBar:(UIView*)view{
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    UIActivityIndicatorView *tmpimg = (UIActivityIndicatorView *)[view viewWithTag:1];
    [tmpimg removeFromSuperview];
}

/*
 Este método converte a data para o padrão de data brasileiro
 /*/

+ (NSString *) converteDataLocalString: (NSDate *) data{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *orignalDate  =  [dateFormatter stringFromDate: data];
    
    return orignalDate;
}
@end
