//
//  DetailViewController.m
//  MyResults
//
//  Created by Dayanand Deshpande on 7/09/14.
//  Copyright (c) 2014 Jay Deshpande. All rights reserved.
//

#import "NamesViewController.h"
#import "User.h"
#import "DetailViewController.h"
#import "subject.h"
#import "GetSubjects.h"


@interface DetailViewController ()
{
    subject *_subject;
    NSArray *_feedItems;
    User *_selectedUser;
    GetSubjects *_getSubjects;
    
}
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set this view controller object as the delegate and data source for the table view
    self.SubjectList.delegate = self;
    self.SubjectList.dataSource = self;
    
    // Create array object and assign it to _feedItems variable
    _feedItems = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _getSubjects = [[GetSubjects alloc] init];
    
    
    int _selectedID = [_selectedUser.U_ID intValue];
    
    
    // Set this view controller object as the delegate for the home model object
    _getSubjects.delegate = self;
    
    // Call the download items method of the home model object
    [_getSubjects downloadSubjects:_selectedID];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)SubjectsDownloaded:(NSArray *)items2
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _feedItems = items2;
    
    // Reload the table view
    [self.SubjectList reloadData];
}

#pragma mark Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of feed items (initially 0)
    return _feedItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Retrieve cell
    NSString *cellIdentifier = @"Cell1";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Get the location to be shown
    subject *item = _feedItems[indexPath.row];
    
    // Get references to labels of cell
    //myCell.textLabel.text = item.F_Name;
    myCell.textLabel.text = item.Subject_Name;
    
    
    return myCell;
}
@end