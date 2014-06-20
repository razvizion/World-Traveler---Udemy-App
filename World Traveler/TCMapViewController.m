//
//  TCMapViewController.m
//  World Traveler
//
//  Created by Michał Kozak on 22.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import "TCMapViewController.h"
#import "Location.h"
#import "FSCategory.h"
#import "TCDirectionsViewController.h"

@interface TCMapViewController ()

@end

@implementation TCMapViewController

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
    
    self.nameLabel.text = self.venue.name;
    self.addressLabel.text = self.venue.location.address;
    
    float latitude  = [self.venue.location.lat floatValue];
    float longitude = [self.venue.location.lng floatValue];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
    point.coordinate = coordinate;
    point.title = self.venue.name;
    point.subtitle = self.venue.categories.name;
    [self.mapView addAnnotation:point];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[TCDirectionsViewController class]]){
        TCDirectionsViewController *directionsVC = segue.destinationViewController;
        directionsVC.venue = self.venue;
    }
}


-(IBAction)showDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"mapToDirectionsSegue" sender:nil];
}

- (IBAction)favoriteButtonPressed:(UIButton *)sender {
    self.venue.favorite = [NSNumber numberWithBool:YES];
    [[NSManagedObjectContext MR_defaultContext]MR_saveOnlySelfAndWait];
}




@end
