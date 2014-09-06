//
//  DetailViewController.h
//  MyResults
//
//  Created by Dayanand Deshpande on 7/09/14.
//  Copyright (c) 2014 Jay Deshpande. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetSubjects.h"


@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, GetSubjectsProtocol>

@property (weak, nonatomic) IBOutlet UITableView *SubjectList;

@property (strong, nonatomic)  User *selectedUser;

@end
