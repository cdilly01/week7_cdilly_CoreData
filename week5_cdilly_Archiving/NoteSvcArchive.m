//
//  NoteSvcArchive.m
//  week7_cdilly_CoreData
//
//  Created by A Student on 6/11/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "NoteSvcArchive.h"

@implementation NoteSvcArchive

NSString *filePath;
NSMutableArray *notes;

- (id) init {
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    filePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"notes.archive"]];
    
    [self readArchive];
    return self;
}

-(void) readArchive {
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: filePath])
    {
        notes = [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
    }
    else
    {
        notes = [NSMutableArray array];
    }
}

-(void) writeArchive {
    [NSKeyedArchiver archiveRootObject: notes toFile: filePath];
}

- (Note *) addNote: (Note *) note {
    NSLog(@"NoteSvc.addNote: %@", [note description]);
    
    [notes addObject: note];
    [self writeArchive];
    
    return note;
}

- (NSMutableArray *) retrieveAllNotes {
    return notes;
}

- (Note *) deleteNote: (Note *) note {
    NSLog(@"NoteSvc.deleteNote: %@", [note description]);
    [notes removeObject: note];
    
    return note;
}

@end
