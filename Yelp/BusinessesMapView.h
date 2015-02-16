//
// Created by Emmanuel Texier on 2/15/15.
// Copyright (c) 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>


@interface BusinessesMapView : GMSMapView
@property (nonatomic, copy) NSArray *businesses;
@end