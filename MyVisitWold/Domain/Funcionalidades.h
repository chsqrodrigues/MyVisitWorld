//
//  Funcionalidades.h
//  MyVisitWold
//
//  Created by Carlos on 15/06/16.
//  Copyright © 2016 Carlos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Funcionalidades : NSObject
+(void)startProgressBar:(UIView*)view;
+(void)stopProgressBar:(UIView*)view;
+ (NSString *) converteDataLocalString: (NSDate *) data;
@end
