//
//  UIHelper.m
//  Yelp
//
//  Created by Emmanuel Texier on 2/14/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "UIHelper.h"


@implementation UIHelper


+ (UIImage *)getMapImage {
    return [UIImage imageNamed:@"map79.png"];
}

+ (UIColor *)getRedColor {
    return [UIColor colorWithRed:0.8 green:0.02 blue:0.02 alpha:1];
}

+(void)initializeNavigationBarStyle {
    // application style
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UINavigationBar appearance] setBarTintColor:[self getRedColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}


@end
