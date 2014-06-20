//
//  TCFavoriteVenuesViewController.h
//  World Traveler
//
//  Created by Michał Kozak on 26.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCFavoriteVenuesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
