//
//  ViewController.m
//  CoreDataExample
//
//  Created by Erick Bennett on 2/12/15.
//  Copyright (c) 2015 Erick Bennett. All rights reserved.
//

#import "ViewController.h"
#import "Human.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    NSError *error = nil;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    
    Human *human = [NSEntityDescription insertNewObjectForEntityForName:@"Human"inManagedObjectContext:context];
    
    human.hairColor = @"Brown";
    human.eyeColor = @"Blue";
    human.eyeColor = @"Black";

    human.age = @(28);
    
    if (![appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Error saving MOC: %@", [error localizedDescription]);
    }
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Human" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.returnsObjectsAsFaults = NO;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age = 28"];
    [request setPredicate:predicate];
    
    //[request setFetchLimit:1];

    [request setEntity:entityDescription];
    
    NSArray *allHumans = [context executeFetchRequest:request error:&error];
    
    NSLog(@"all humans = %@", allHumans);
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
