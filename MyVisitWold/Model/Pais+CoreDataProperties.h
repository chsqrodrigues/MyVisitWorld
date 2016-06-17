//
//  Pais+CoreDataProperties.h
//  MyVisitWold
//
//  Created by Carlos on 15/06/16.
//  Copyright © 2016 Carlos. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Pais.h"

NS_ASSUME_NONNULL_BEGIN

@interface Pais (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *idPais;
@property (nullable, nonatomic, retain) NSString *iso;
@property (nullable, nonatomic, retain) NSString *shortname;
@property (nullable, nonatomic, retain) NSString *longname;
@property (nullable, nonatomic, retain) NSString *callingCode;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSString *culture;
@property (nullable, nonatomic, retain) NSData *bandeira;
@property (nullable, nonatomic, retain) NSString *visitado;
@property (nullable, nonatomic, retain) NSString *date;
@property (nullable, nonatomic, retain) NSString *selected;

@end

NS_ASSUME_NONNULL_END
