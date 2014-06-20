//
//  TCFourSquareSessionManager.h
//  World Traveler
//
//  Created by Michał Kozak on 23.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface TCFourSquareSessionManager : AFHTTPSessionManager

+(instancetype)sharedClient;

@end
