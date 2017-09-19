//
//  ViewController.m
//  Weather
//
//  Created by Ajay Somanal on 9/18/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

//Action method called when "Tell me" button clicked
- (IBAction)fetchWeatherDetails:(id)sender {
    
    // City name not entered then display alert
   if ( ![self.cityNameText.stringValue isEqualToString:@""])
   {
       
       self.cityName.stringValue = self.cityNameText.stringValue;
       //Fecth weather details for the city name entered
       [[WeatherCoreService sharedManager] fetchWeatherDetails:self.cityNameText.stringValue
                                         withCompletionHandler:^(NSDictionary *weatherDetails,
                                                                 NSError* error) {
                                             if (error == nil)
                                             {
                                                 //Update UI with
                                                 NSLog(@"Weather details : %@",weatherDetails);
                                                 [self updateUI:weatherDetails];
                                            }
                                             else
                                             {
                                                 [self displayAlertMessage:@"Could not fetch weather details"];
                                             }
                                         }];
   }
    else
    {
        [self displayAlertMessage:@"Please enter the City name to see the weather details"];
    }
}


//Update UI based by reading values from dictionary
-(void) updateUI:(NSDictionary *)weatherDetails
{
    NSDictionary *mainValue = [weatherDetails objectForKey:@"main"] ;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.humidity.stringValue =[NSString stringWithFormat:@"%@%%",[mainValue valueForKey:@"humidity"]];
        NSString *tempValue = [mainValue valueForKey:@"temp"];
        self.temp.stringValue = [NSString stringWithFormat:@"%0.2f",tempValue.integerValue - 273.15];
        NSDictionary * windDetails = [weatherDetails objectForKey:@"wind"];
        
        self.wind.stringValue = [NSString stringWithFormat:@"%@ m/h", [windDetails valueForKey:@"speed"]];
        
        NSDictionary *weatherDetail = [[weatherDetails objectForKey:@"weather"]  objectAtIndex:0];
        NSString *weatherImage = [NSString stringWithFormat:@"%@.png",[weatherDetail  valueForKey:@"icon"]];
        self.image.image = [NSImage imageNamed:weatherImage];
    });
}


-(void)displayAlertMessage : (NSString *)message
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Weather"];
    [alert setInformativeText:message];
    [alert addButtonWithTitle:@"Ok"];
    [alert runModal];
}
@end
