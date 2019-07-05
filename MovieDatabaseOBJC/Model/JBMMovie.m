//
//  JBMMovie.m
//  MovieDatabaseOBJC
//
//  Created by Jason Mandozzi on 7/5/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

#import "JBMMovie.h"

static NSString * const titleKey = @"title";
static NSString * const overviewKey = @"overview";
static NSString * const ratingKey = @"vote_average";
static NSString * const imageKey = @"poster_path";

@implementation JBMMovie

- (instancetype)initWithTitle:(NSString *)title overview:(NSString *)overview rating:(NSNumber *)rating
{
    self = [super init];
    if (self != nil)
    {
        _title = title;
        _overview = overview;
        _rating = rating;
//        _image = image;
    }
    return self;
}

@end

@implementation JBMMovie (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *title = dictionary[titleKey];
    NSString *overview = dictionary[overviewKey];
    NSNumber *rating = dictionary[ratingKey];
//    NSString *image = dictionary[imageKey];
    
    return [self initWithTitle:title overview:overview rating:rating];
}

@end
