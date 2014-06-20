//
//  TCMapViewController.h
//  World Traveler
//
//  Created by Michał Kozak on 22.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"

@interface TCMapViewController : UIViewController
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) Venue *venue;


@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;


- (IBAction)showDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)favoriteButtonPressed:(UIButton *)sender;

@end
