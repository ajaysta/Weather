//
//  WeatherCoreService.m
//  WeatherCoreService
//
//  Created by Ajay Somanal on 9/17/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

#import "WeatherCoreService.h"

static WeatherCoreService *sharedManager = nil;


@implementation WeatherCoreService : NSObject 


+ (WeatherCoreService *)sharedManager
{
    @synchronized([WeatherCoreService class])
    {
        if (!sharedManager)
            sharedManager = [[self alloc] init];
        return sharedManager;
    }
    return nil;
}



- (void) fetchWeatherDetails:(NSString*_Nullable)cityName withCompletionHandler:( void(^_Nullable)( NSDictionary *weatherDetails, NSError * _Nullable error)) completionHandler
{
    NSString *baseURL = @"https://api.openweathermap.org/data/2.5/weather?q=CITY_NAME,us&APPID=e8c81ff605eddddeaede1b25a80d8598";
    
    NSString *UrlToFetchWeather = [baseURL stringByReplacingOccurrencesOfString:@"CITY_NAME" withString:cityName];
    
    NSURL *url = [NSURL URLWithString:[UrlToFetchWeather stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                             completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                                 if (((NSHTTPURLResponse *) response).statusCode == 200) {
                                                                     NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                             options:NSJSONReadingAllowFragments
                                                                                                                               error:nil];
                                                                     
                                                                     completionHandler(jsonObj, nil);
                                                                 }
                                                                 else {
                                                                     if(error){
                                                                         completionHandler(nil, error);
                                                                     }
                                                                     else {
                                                                         completionHandler(nil, [NSError errorWithDomain:@"WeatherCoreService"
                                                                                                                    code:-1
                                                                                                                userInfo:@{NSLocalizedDescriptionKey:@"Unexpected server error"}]);
                                                                     }
                                                                 }

                                                             }];
    
    [task resume];
    
    
}


@end
