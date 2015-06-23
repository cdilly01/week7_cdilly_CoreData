//
//  NoteSvcSQLite.m
//  week7_cdilly_CoreData
//
//  Created by A Student on 6/15/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "NoteSvcSQLite.h"
#import "sqlite3.h"

@implementation NoteSvcSQLite

NSString *databasePath = nil;
sqlite3 *database= nil;


// sqlite implementation
-(id)init{
    if((self = [super init])){
        
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        databasePath = [documentsDir stringByAppendingPathComponent:@"note.sqlite3"];
        
        if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
            NSLog(@"database is open");
            NSLog(@"database file path: %@", databasePath);
            
            NSString *createSql = @"create table if not exists note (id integer primary key autoincrement, noteText varchar(255))";
            
            char *errMsg;
            if (sqlite3_exec(database, [createSql UTF8String], NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog(@"Failed to create table %s", errMsg);
            }
        }
        else{
            NSLog(@"*** Failed to open database!");
            NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
    }
    return self;
}

-(Note *) addNote: (Note *) note{
    sqlite3_stmt *statement;
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO note (noteText) VALUES (\"%@\")", note.noteText];

    if (sqlite3_prepare_v2(database, [insertSQL UTF8String], -1, &statement, NULL)==SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_DONE){
            note.id = sqlite3_last_insert_rowid(database);
            NSLog(@"*** Note added");
        }
        else{
            NSLog(@"*** Note NOT added");
            NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
        sqlite3_finalize(statement);
    }
    return note;
}

-(Note *) deleteNote: (Note *) note{
    NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM note WHERE id = %i ", (int)note.id];
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(database, [deleteSQL UTF8String], -1, &statement, NULL)==SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"*** Note Deleted");
        }
        else {
            NSLog(@"*** Note NOT Deleted");
            NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
        sqlite3_finalize(statement);
    }
    
    return note;
}

-(void)dealloc{
    //sqlite3_close(database); // this is causing an error when switching views.
}

-(NSMutableArray *) retrieveAllNotes{
    NSMutableArray *notes = [NSMutableArray array];
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM note ORDER BY id"];
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(database, [selectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        NSLog(@"*** Notes retrieved");
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int id = sqlite3_column_int(statement, 0);
            char *noteTextChars = (char *)sqlite3_column_text(statement, 1);
            
            Note *note = [[Note alloc] init];
            note.id = id;
            note.noteText = [[NSString alloc] initWithUTF8String:noteTextChars];
            [notes addObject:note];
        }
        sqlite3_finalize(statement);
    }
    else{
        NSLog(@"*** Notes NOT retrieved");
        NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
    }
    
    return notes;
}


@end
