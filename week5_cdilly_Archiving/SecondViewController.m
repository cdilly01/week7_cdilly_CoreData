//
//  SecondViewController.m
//  week7_cdilly_CoreData
//
//  Created by A Student on 6/11/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "SecondViewController.h"
#import "Note.h"
//#import "NoteSvcCache.h"
//#import "NoteSvcArchive.h"
//#import "NoteSvcSQLite.h"
#import "NoteSvcCoreData.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

//NoteSvcArchive *secondNoteSvcArchive = nil;
//NoteSvcSQLite *secondNoteSvcSQLite = nil;
NoteSvcCoreData *secondNoteSvcCoreData = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    secondNoteSvcCoreData = [[NoteSvcCoreData alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Return the number of notes
- (NSInteger)tableView:(UITableView *)secondTableView numberOfRowsInSection:(NSInteger)section
{
    return [[secondNoteSvcCoreData retrieveAllNotes] count];
}


// Return the table cell for a paricular row (index)
- (UITableViewCell *)tableView:(UITableView *)secondTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell =
    [secondTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:simpleTableIdentifier];
    }
    
    Note *note = [[secondNoteSvcCoreData retrieveAllNotes]
                  objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [note description];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    return cell;
}

@end
