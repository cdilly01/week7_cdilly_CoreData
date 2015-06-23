//
//  NoteSvcCoreData.m
//  week7_cdilly_CoreData
//
//  Created by A Student on 6/21/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "NoteSvcCoreData.h"
#import "CoreData-Prefix.pch"

@implementation NoteSvcCoreData

NSManagedObjectModel *model = nil;
NSPersistentStoreCoordinator *psc = nil;
NSManagedObjectContext *moc = nil;

NSMutableArray *notesArrayCoreData = nil;

-(id) init {
    if (self = [super init]) {
        [self initializeCoreData];
        return self;
    }
    return nil;
}

- (Note *) deleteNote:(Note *)note{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:moc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"noteText = %@", note.noteText];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedObjects count] == 1)
    {
        NSManagedObject *managedObject = [fetchedObjects objectAtIndex:0];
        [moc deleteObject:managedObject];
    }
    return note;
}

- (Note *) addNote: (Note *) note {
    NSManagedObject *managedObject =
    [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:moc];
    [managedObject setValue:note.noteText forKey:@"noteText"];
    NSError *error;
    if (![moc save:&error]){
        NSLog(@"addNote ERROR: %@", [error localizedDescription]);
    }
    return note;
}

- (NSMutableArray *) retrieveAllNotes {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:moc];
    
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *notes = [NSMutableArray arrayWithCapacity:fetchedObjects.count];
    
    for (NSManagedObject *manageObject in fetchedObjects) {
        Note *note = [[Note alloc] init];
        note.noteText = [manageObject valueForKey:@"noteText"];
        NSLog(@"note: %@ ", [note description]);
        [notes addObject:note];
    }
    
    return notes;
}

-(void) initializeCoreData{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL: modelURL];
    
    NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    NSURL *storeURL = [applicationDocumentsDirectory URLByAppendingPathComponent:@"week7_cdilly_CoreData.sqlite"];
    NSError *error = nil;
    psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    if ([psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [moc setPersistentStoreCoordinator:psc];
    }
    else
    {
        NSLog(@"initializeCoreData FAILED with error : %@", error);
    }
}

@end
