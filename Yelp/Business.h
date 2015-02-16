//
//  Business.h
//  Yelp
//
//  Created by Emmanuel Texier on 2/10/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>



@interface Business : NSObject

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ratingImageUrl;
@property (nonatomic, assign) NSInteger numReviews;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *categories;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;


+(NSArray *)businessesWithDictionaries:(NSArray *)dictionaries;

@end
