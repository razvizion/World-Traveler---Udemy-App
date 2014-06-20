//
//  FSCategory.h
//  World Traveler
//
//  Created by Michał Kozak on 22.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TCRecord.h"


@interface FSCategory : TCRecord

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *venue;

@end
