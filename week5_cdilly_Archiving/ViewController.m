//
//  ViewController.m
//  week7_cdilly_CoreData
//
//  Created by A Student on 6/11/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "ViewController.h"
#import "Note.h"
//#import "NoteSvcCache.h"
//#import "NoteSvcArchive.h"
//#import "NoteSvcSQLite.h"
#import "NoteSvcCoreData.h"

@interface ViewController ()

@end

@implementation ViewController

//NoteSvcArchive *noteSvcArchive = nil;
//NoteSvcSQLite *noteSvcSQLite = nil;
NoteSvcCoreData *noteSvcCoreData = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    noteSvcCoreData = [[NoteSvcCoreData alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Save Note
- (IBAction)addNote:(id)sender {
    [self.view endEditing:YES];
    
    if (_noteInputText.text.length != 0){
        NSLog(@"addNote");
        
        // instantiate new note with sender note
        Note *note = [[Note alloc] init];
        note.noteText = _noteInputText.text;
    
        [noteSvcCoreData addNote:note];
    
        [self.tableView reloadData];
        NSLog(@"saveNote: note saved");
    }
    else{
        NSLog(@"empty note, will not add");
    }
}

// Delete Note
- (IBAction)deleteNote:(id)sender {
    [self.view endEditing:YES];
    NSLog(@"deleteNote");
    
    // instantiate new note with sender note
    Note *note = [[Note alloc] init];
    note.noteText = _noteInputText.text;
    
    [noteSvcCoreData deleteNote:note];
    
    [self.tableView reloadData];
    NSLog(@"deleteNote: note deleted");
}


// Return the number of notes
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[noteSvcCoreData retrieveAllNotes] count];
}

// Return the table cell for a paricular row (index)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:simpleTableIdentifier];
    }
    
    Note *note = [[noteSvcCoreData retrieveAllNotes]
                  objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [note description];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    return cell;
}

@end
