//
//  JBMMovieController.h
//  MovieDatabaseOBJC
//
//  Created by Jason Mandozzi on 7/5/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JBMMovie.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBMMovieController : NSObject

+ (instancetype) sharedInstance;

- (void)fetchMovieWithSearch:(NSString *)search completion: (void (^)(NSArray<JBMMovie *>* movies))completion;
- (void)fetchImage:(JBMMovie *)movieToFetchImage completion: (void (^)(UIImage * image))completion;

@end

NS_ASSUME_NONNULL_END
