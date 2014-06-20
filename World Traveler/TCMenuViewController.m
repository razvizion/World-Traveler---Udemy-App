//
//  TCMenuViewController.m
//  World Traveler
//
//  Created by Michał Kozak on 26.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import "TCMenuViewController.h"
#import "TCListViewController.h"
#import "TCAppDelegate.h"

@interface TCMenuViewController ()

@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) UINavigationController *listNavigationController;

@property (strong, nonatomic) UINavigationController *favoriteVenuesNavigationController;
@property (strong, nonatomic) UINavigationController *addVenueNavigationController;


@end

@implementation TCMenuViewController

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
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    if (!self.viewControllers) {
        self.viewControllers = [[NSMutableArray alloc]initWithCapacity:3];
    }
 }

-(void)viewDidAppear:(BOOL)animated
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if(!self.listNavigationController){
        MMDrawerController *drawController = [self drawControllerFromAppDelegate];
        self.listNavigationController = (UINavigationController *)drawController.centerViewController;
        [self.viewControllers addObject:self.listNavigationController];
    }
    
    if(!self.favoriteVenuesNavigationController){
        self.favoriteVenuesNavigationController = (UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"TCFavoriteVenuesViewControllerID"];
        [self.viewControllers addObject:self.favoriteVenuesNavigationController];
    }
    if(!self.addVenueNavigationController){
        self.addVenueNavigationController = (UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"TCAddVenueViewControllerID"];
        [self.viewControllers addObject:self.addVenueNavigationController];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewControllers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.row == 0){
        cell.textLabel.text = @"Home";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"Favorites";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"Add";
    }
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MMDrawerController *drawController = [self drawControllerFromAppDelegate];
    [drawController setCenterViewController:self.viewControllers[indexPath.row] withCloseAnimation:YES completion:nil];
}

#pragma mark - DrawController Helper

-(MMDrawerController *)drawControllerFromAppDelegate
{
    TCAppDelegate *appDelegate = (TCAppDelegate *) [[UIApplication sharedApplication]delegate];
    return appDelegate.drawerController;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
