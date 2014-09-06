//
//  NamesViewController.h
//  MyResults
//
//  Created by Dayanand Deshpande on 7/09/14.
//  Copyright (c) 2014 Jay Deshpande. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface NamesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, HomeModelProtocol>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end
