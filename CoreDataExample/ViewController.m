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
    
    //1. Creates a Human object from an Entity configured in our CoreData model
    //2. Assigns some values to its properties
    //3. Saves the newly created Human object
    //4. Next a fetch request with a predicate is created to search the CoreData entity 'Human' for all Human objects with an age of 28.
    //5 The fetch request is executed and returns an array of objects matching the 'Human' entity with an age of 28.
    

    //Grab a reference to our appdelegate since that is where all the core data methods are.
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    //Get the managed object context from our appdelegate
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    //Create a new Human object in Core Data using the entity name. This is the entity we created in our core data model file (CoreDataExample.xcdatamodeld)
    Human *human = [NSEntityDescription insertNewObjectForEntityForName:@"Human"inManagedObjectContext:context];
    
    //make some changes to our new Human object
    human.hairColor = @"Brown";
    human.eyeColor = @"Blue";
    human.eyeColor = @"Black";
    human.age = @(28);
    
    //Create an NSError for use when we are trying to save this new object
    NSError *error = nil;

    //Use the 'save' method in our managedObjectContext instance. This method returns a BOOL specifying wether the operation was succesfull or not.
    if (![appDelegate.managedObjectContext save:&error]) {
        NSLog(@"Error saving MOC: %@", [error localizedDescription]);
    }
    
    
    //Fetching data
    
    //Create a NSEntityDescription that points to the entity in Core Data we want to search through
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Human" inManagedObjectContext:context];
    
    
    //Create a fetch request that will get data from the entity listed in the NSEntityDescription above.
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    
    //Set the entity for the request
    [request setEntity:entityDescription];
    
    //Using this makes sure we get the full object(s) returned rather than a pointer to object(s) that will become a full object when we access its properties.
    request.returnsObjectsAsFaults = NO;
    
    //Create a predicate so the fetch can be refined to look for specific data. See the NSPredicate quick help for the search string syntax.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age = 28"];
    
    //Set this predicate to our fetch request
    [request setPredicate:predicate];
    
    //This would limit it to retuning only 1 object that matches
    //[request setFetchLimit:1];

    //Execute the fetch request. It will return an Array of objects
    NSArray *allHumans = [context executeFetchRequest:request error:&error];
    
    //Log array to console
    NSLog(@"all humans = %@", allHumans);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
