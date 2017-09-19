//
//  ViewController.h
//  Weather
//
//  Created by Ajay Somanal on 9/18/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WeatherCoreService/WeatherCoreService.h>
#import <CoreLocation/CLLocationManager.h>

@interface ViewController : NSViewController
@property (weak) IBOutlet NSTextField *cityName;
@property (weak) IBOutlet NSTextField *temp;
@property (weak) IBOutlet NSTextField *wind;
@property (weak) IBOutlet NSImageView *image;
@property (weak) IBOutlet NSButton *fetchWeatherDetails;
@property (weak) IBOutlet NSTextField *cityNameText;
@property (weak) IBOutlet NSTextField *humidity;


- (IBAction)fetchWeatherDetails:(id)sender;

@end

