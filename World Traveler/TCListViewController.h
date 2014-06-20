//
//  TCViewController.h
//  World Traveler
//
//  Created by Michał Kozak on 18.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)refreshBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
