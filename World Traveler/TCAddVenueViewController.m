//
//  TCAddVenueViewController.m
//  World Traveler
//
//  Created by Michał Kozak on 26.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import "TCAddVenueViewController.h"
#import "TCAppDelegate.h"
#import "Venue.h"
#import "Contact.h"
#import "FSCategory.h"

@interface TCAddVenueViewController ()

@end

@implementation TCAddVenueViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)saveButtonPressed:(UIButton *)sender {
    if([self.venueNameTextField.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Blank Field" message:@"Please enter venue name" delegate:nil cancelButtonTitle:@"Ok!" otherButtonTitles: nil];
        [alertView show];
    }
    else{
        Venue *venue = [Venue MR_createEntity];
        venue.name = self.venueNameTextField.text;
        Contact *contant = [Contact MR_createEntity];
        contant.phone = self.phoneNumberTextField.text;
        venue.contact = contant;
        FSCategory *category = [FSCategory MR_createEntity];
        category.name = self.typeOfFoodTextField.text;
        venue.categories=category;
        venue.favorite = [NSNumber numberWithBool:YES];
        [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
    }
}

- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender {
    
    [[self drawControllerFromAppDelegate] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - DrawController Helper

-(MMDrawerController *)drawControllerFromAppDelegate{
    TCAppDelegate *appDelegate = (TCAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.drawerController;
}
@end
