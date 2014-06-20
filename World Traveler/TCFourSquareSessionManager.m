//
//  TCFourSquareSessionManager.m
//  World Traveler
//
//  Created by Michał Kozak on 23.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import "TCFourSquareSessionManager.h"

@implementation TCFourSquareSessionManager
static NSString *const TCFoursquareBaseURLString = @"https://api.foursquare.com/v2/";


+(instancetype) sharedClient
{
    static TCFourSquareSessionManager *_sharedClient=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[TCFourSquareSessionManager alloc]initWithBaseURL:[NSURL URLWithString:TCFoursquareBaseURLString]];
    });
    return _sharedClient;
}

@end
