//
//  SecondViewController.h
//  week7_cdilly_CoreData
//
//  Created by A Student on 6/11/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface SecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *secondTableView; 

- (NSInteger)tableView:(UITableView *)secondTableView
 numberOfRowsInSection:(NSInteger)section;

@end
