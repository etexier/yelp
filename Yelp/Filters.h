//
// Created by Emmanuel Texier on 2/14/15.
// Copyright (c) 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Filters : NSObject <NSCopying>

@property(nonatomic, strong) NSNumber *selectedDistance;
@property(nonatomic, strong) NSNumber *selectedSortMode;
@property(nonatomic, strong) NSMutableSet *selectedCategories;

@property(nonatomic, assign) BOOL dealsOnlySelected;

@property(nonatomic, copy) NSString *searchTerm;

@property(nonatomic, strong) NSArray *categories;
@property(nonatomic, strong) NSArray *sortModes;
@property(nonatomic, strong) NSArray *distances;
@property(nonatomic, strong) NSDictionary *searchParameters;

typedef NS_ENUM(NSInteger, Filter) {
    FilterDistance,
    FilterSortMode,
    FilterDealsOnly,
    FilterCategories,
    FilterCount,
};


- (id)initWithDefaults;

@end
