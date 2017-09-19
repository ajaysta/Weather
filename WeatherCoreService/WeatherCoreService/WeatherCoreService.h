//
//  WeatherCoreService.h
//  WeatherCoreService
//
//  Created by Ajay Somanal on 9/17/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WeatherCoreService.h"

//! Project version number for WeatherCoreService.
FOUNDATION_EXPORT double WeatherCoreServiceVersionNumber;

//! Project version string for WeatherCoreService.
FOUNDATION_EXPORT const unsigned char WeatherCoreServiceVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <WeatherCoreService/PublicHeader.h>


@interface WeatherCoreService : NSObject
{

}

+ (WeatherCoreService *_Nullable)sharedManager;

//Fetches weahter for given city 
- (void) fetchWeatherDetails:(NSString*_Nullable)cityName withCompletionHandler:( void(^_Nullable)( NSDictionary * _Nullable weatherDetails,NSError * _Nullable error)) completionHandler;


@end


