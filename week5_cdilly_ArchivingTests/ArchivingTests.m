//
//  week6_cdilly_ArchivingTests.m
//  week6_cdilly_ArchivingTests
//
//  Created by A Student on 6/11/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ArchivingTests.h"
#import "Note.h"    
#import "NoteSvcArchive.h"

@implementation ArchivingTests

static NSString *const TESTNOTETEXT = @"This is some note!";

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNoteSvcArchive {
    NSLog(@"*** Starting testNoteSvcArchive ***");
    NoteSvcArchive *noteSvc = [[NoteSvcArchive alloc] init];
    int initialCount = [[noteSvc retrieveAllNotes] count];
    
    Note *note = [[Note alloc] init];
    note.noteText = TESTNOTETEXT;
    
    [noteSvc addNote:(Note *) note];
    int finalCount = [[noteSvc retrieveAllNotes] count];
    
    //STAssertEquals(initialCount + 1, finalCount, @"initial count %@, final count %@ ", initialCount, finalCount);

    NSLog(@"*** The initial count: %i", initialCount );
    NSLog(@"*** The final count: %i", finalCount );
    NSLog(@"*** Ending testNoteSvcArchive ***");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
