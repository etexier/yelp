//
//  YelpClient.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YelpClient.h"
#import <CoreLocation/CoreLocation.h>


@interface YelpClient ()

// unused
@property(nonatomic, retain) CLLocationManager *locationManager;

@end

@implementation YelpClient

- (id)initWithConsumerKey:(NSString *)consumerKey
           consumerSecret:(NSString *)consumerSecret
              accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:accessToken secret:accessSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term
                                    params:(NSDictionary *) params
                                   success:(void (^)(AFHTTPRequestOperation *operation, id response))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    // geo-location (unused)
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];


    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSDictionary *defaults = @{@"term" : term, @"ll" : @"37.371111,-122.0375"}; // sunnyvale
    NSMutableDictionary *allParameters = [defaults mutableCopy];
    if (params) {
        [allParameters addEntriesFromDictionary:params];
    }

    return [self GET:@"search" parameters:allParameters success:success failure:failure];
}

// not used
- (NSString *)deviceLocation {
    NSString *theLocation = [NSString stringWithFormat:@"%f,%f",
                    self.locationManager.location.coordinate.latitude,
                    self.locationManager.location.coordinate.longitude];
    NSLog(@"Location: latitude,longitude=%@", theLocation);
    return theLocation;
}


@end
