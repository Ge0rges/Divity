//
//  Divity.h
//  Divity
//
//  Created by Georges Kanaan on 17/03/2017.
//
//

#import <Foundation/Foundation.h>

@interface Divity : NSObject

typedef enum NSMotionType : NSUInteger {
  NSMotionSport = 0,
  NSMotionIdle,
  NSMotionMoving,
  
} NSMotionType;

typedef enum NSTransportationMode : NSUInteger {
  NSTransportationModeWalking = 0,
  NSTransportationModeRunning,
  NSTransportationModeCycling,
  NSTransportationModeCar,
  NSTransportationModeTrain,
  NSTransportationModeBoat,
  NSTransportationModeHelicopter,
  NSTransportationModePlane,
  
} NSTransportationMode;

typedef enum NSWeatherState : NSUInteger {//https://openweathermap.org/weather-conditions
  NSWeatherStateClear = 0,
  NSWeatherStateFoggy,
  NSWeatherStateCloudy,
  NSWeatherStateRain,
  NSWeatherStateSnow,
  NSWeatherStateDrizzle,
  NSWeatherStateThunderstorm,
  NSWeatherStateExtreme,
  NSWeatherStateOther,
  
} NSWeatherState;

typedef void (^handler)(Divity *currentDivity);
+ (void)calculateCurrentDivity:(handler)handler;

@property (readonly, nonatomic) NSMotionType motionType;
@property (readonly, nonatomic) NSTransportationMode transportationMode;
@property (readonly, nonatomic) NSWeatherState weather;
@property (readonly, nonatomic) BOOL playingMusic;
@property (readonly, nonatomic) BOOL usingHeadphones;
@property (strong, readonly, nonatomic) NSDictionary *place;// Courtesy of Foursquare

// Activity is based upon all of the above. It's an action in english.
@property (strong, readonly, nonatomic) NSString *likelyActivity;

@end
