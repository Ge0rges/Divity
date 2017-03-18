//
//  Divity.m
//  Divity
//
//  Created by Georges Kanaan on 17/03/2017.
//
//

#import "Divity.h"

@interface Divity ()

@property (nonatomic) NSMotionType motionType;
@property (nonatomic) NSTransportationMode transportationMode;
@property (nonatomic) NSWeatherState weather;
@property (nonatomic) BOOL playingMusic;
@property (nonatomic) BOOL usingHeadphones;
@property (strong, nonatomic) NSDictionary *place;// Courtesy of Foursquare

// Activity is based upon all of the above. It's an action in english.
@property (strong, nonatomic) NSString *likelyActivity;

@end

@implementation Divity

// Different datapoints to build a divity upon:

// On board data
//NSDivitiWeather = 0,
//NSDivityMotion,// Running, walking, car, train, plane...
//NSDivityMicrophoneLevel,// Used to narrow down places eg bar or park.
//NSDivityCalendar,// Currently in a meeting?
//NSDivityReminders,// Investigate.
//NSDivityHomeKit,// Investigate.
//NSDivityHealthKit,// Heart rate
//NSDivityMusic,// Listenning to music or not.
//NSDivityTime,
//NSDivityAltitude
//
//// 3rd Party Services & Apps
//NSDivityUber,// In a ride or not.
//NSDivityFoursquare,// This renders location useful by giving it context.

+ (void)calculateCurrentDivity:(handler)handler {
  
}

@end
