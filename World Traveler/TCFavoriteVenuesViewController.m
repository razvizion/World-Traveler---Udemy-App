//
//  TCFavoriteVenuesViewController.m
//  World Traveler
//
//  Created by Michał Kozak on 26.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import "TCFavoriteVenuesViewController.h"
#import "TCAppDelegate.h"
#import "Venue.h"

@interface TCFavoriteVenuesViewController ()

@property (strong, nonatomic) NSMutableArray *favorites;

@end

@implementation TCFavoriteVenuesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate= self;
    
    // Do any additional setup after loading the view.
    if(!self.favorites){
        self.favorites = [[NSMutableArray alloc]init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    NSPredicate *predicateForFavorites = [NSPredicate predicateWithFormat:@"favorite == %@", [NSNumber numberWithBool:YES]];
    self.favorites = [[Venue MR_findAllWithPredicate:predicateForFavorites] mutableCopy];
    [self.tableView reloadData];
}

- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender {
    
    [[self drawControllerFromAppDelegate] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.favorites count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Venue *venue = self.favorites[indexPath.row];
    cell.textLabel.text=venue.name;
    return cell;
}


#pragma mark - DrawController Helper

-(MMDrawerController *)drawControllerFromAppDelegate{
    TCAppDelegate *appDelegate = (TCAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.drawerController;
}
@end
