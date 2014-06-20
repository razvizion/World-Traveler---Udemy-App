//
//  TCDirectionsViewController.h
//  World Traveler
//
//  Created by Michał Kozak on 24.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"
#import "Location.h"


@interface TCDirectionsViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>


@property (strong, nonatomic) Venue *venue;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) NSArray *steps;

@property (strong, nonatomic) IBOutlet MKMapView *directionsMap;


- (IBAction)listDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
