//
//  Human.h
//  CoreDataExample
//
//  Created by Erick Bennett on 2/12/15.
//  Copyright (c) 2015 Erick Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Human : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * eyeColor;
@property (nonatomic, retain) NSString * hairColor;

@end
