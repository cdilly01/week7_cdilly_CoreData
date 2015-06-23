//
//  SQLiteTests.m
//  week7_cdilly_CoreData
//
//  Created by A Student on 6/16/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SQLiteTests.h"
#import "Note.h"
#import "NoteSvcSQLite.h"

@implementation SQLiteTests

static NSString *const TESTNOTETEXT = @"This is some note!";

-(void)testNoteSvcSQLLite{
    NSLog(@" ");
    NSLog(@"*** Starting testNoteSvcSQLite ***");
    
    // todo
    NoteSvcSQLite *noteSvc =[[NoteSvcSQLite alloc] init];
    Note *note = [[Note alloc]init];
    note.noteText = TESTNOTETEXT;
    
    // add note
    [noteSvc addNote:note];
    
    NSMutableArray *notes = [noteSvc retrieveAllNotes];
    NSLog(@"*** number of contacts: %lu", (unsigned long)notes.count);
    
    // delete note
    [noteSvc deleteNote:note];
    
    NSLog(@"*** Ending testNoteSvcSQLite ***");
    NSLog(@" ");
}



@end