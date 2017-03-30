//
//  Divity.m
//  Divity
//
//  Created by Georges Kanaan on 17/03/2017.
//
//

#import "Divity.h"

// Frameworks
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>

@interface Divity ()

@property (nonatomic) NSMotionType motionType;
@property (nonatomic) NSTransportationMode transportationMode;
@property (nonatomic) NSWeatherState weather;
@property (nonatomic) NSListenningMode listenningMode;
@property (nonatomic) BOOL playingMusic;
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

+ (instancetype)sharedDivity {
  static Divity *sharedDivity = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedDivity = [[self alloc] init];
  });
  
  return sharedDivity;
}

- (void)calculateCurrentDivity:(handler)handler {
  // Set playingMusic
  self.playingMusic = [[AVAudioSession sharedInstance] isOtherAudioPlaying];
  
  // Set listenning mode
  [self setListenningMode];
  
  // Motion Type
  CMMotionActivityManager *motionActivityManager = [CMMotionActivityManager new];
  [motionActivityManager startActivityUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMMotionActivity * _Nullable activity) {
    [self determineMotionAndTransportationTypesFromActivity:activity];
    [motionActivityManager stopActivityUpdates];
  }];
  
#warning handler is never called
#warning weather is never set
#warning place and likely activity not set
}

- (void)setListenningMode {
  AVAudioSessionRouteDescription* route = [[AVAudioSession sharedInstance] currentRoute];
  for (AVAudioSessionPortDescription* desc in [route outputs]) {
    if ([[desc portType] isEqualToString:AVAudioSessionPortHeadphones]) {
      self.listenningMode = NSListenningModeHeadphones;
    
    } else if ([[desc portType] isEqualToString:AVAudioSessionPortCarAudio]) {
      self.listenningMode = NSListenningModeCar;

    } else if ([[desc portType] isEqualToString:AVAudioSessionPortUSBAudio]) {
      self.listenningMode = NSListenningModeUSB;

    } else if ([[desc portType] isEqualToString:AVAudioSessionPortBuiltInSpeaker]) {
      self.listenningMode = NSListenningModeSpeaker;

    } else {
      self.listenningMode = NSListenningModeOther;
    }
  }
}

- (void)determineMotionAndTransportationTypesFromActivity:(CMMotionActivity * _Nonnull)activity {
  if (activity.unknown) {
    self.motionType = NSMotionUnknown;
    self.transportationMode = NSTransportationModeUnknown;
  
  } else if (activity.stationary) {
    self.motionType = NSMotionIdle;
    
    // Only set to unknown if there is no previous t. mode.
    if (!self.transportationMode) {
      self.transportationMode = NSTransportationModeUnknown;
    }
  
  } else if (activity.walking) {
    self.motionType = NSMotionWalking;
#warning determine if walking or running
    self.transportationMode = NSTransportationModeWalking;
  
  } else if (activity.cycling) {
    self.motionType = NSMotionAutomotive;
    self.transportationMode = NSTransportationModeCycling;
  
  } else if (activity.automotive) {
    self.motionType = NSMotionAutomotive;
#warning determine transportation mode: car, train, boat, helicopter or unknown
    self.transportationMode = NSTransportationModeCycling;
  }
}

@end
