//
//  TCAppDelegate.h
//  World Traveler
//
//  Created by Michał Kozak on 18.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"

@interface TCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) MMDrawerController *drawerController;

@end
