//
// Created by Emmanuel Texier on 2/15/15.
// Copyright (c) 2015 codepath. All rights reserved.
//

#import "Filters.h"
#import "YelpException.h"


@implementation YelpException {

}
+ (NSException *)throwsException {
    // should not happen!
    return [NSException exceptionWithName:NSInvalidArgumentException reason:@"invalid" userInfo:nil];

}
@end