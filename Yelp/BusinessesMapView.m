//
// Created by Emmanuel Texier on 2/15/15.
// Copyright (c) 2015 codepath. All rights reserved.
//

#import "BusinessesMapView.h"
#import "Business.h"



// hardcoded sunnyvale locations, could get this from Yelp response instead
static double latitude = 37.37058543251194;
static double longitude = -122.035725;
static double latitude_delta = 0.04274035152629097;
static double longitude_delta = 0.04917000000000371;


@implementation BusinessesMapView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.myLocationEnabled = YES;
    }
    return self;
}

- (void)setBusinesses:(NSArray *)businesses {
    _businesses = businesses;
    [self reload];
}

- (void)reload {
    [self clear];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude
                                                                 zoom:12];
    self.camera = camera;
    for (Business *business in self.businesses) {
        [self addPinForBusiness:business];
    }
}

- (void)addPinForBusiness:(Business *)business {
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.map = self;
    marker.title = business.name;
    marker.snippet = business.address;
    marker.position = business.coordinate;
}

@end
