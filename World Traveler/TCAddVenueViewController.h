//
//  TCAddVenueViewController.h
//  World Traveler
//
//  Created by Michał Kozak on 26.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCAddVenueViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *venueNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *typeOfFoodTextField;

- (IBAction)saveButtonPressed:(UIButton *)sender;
- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
