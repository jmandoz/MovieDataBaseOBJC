//
//  JBMMovieController.m
//  MovieDatabaseOBJC
//
//  Created by Jason Mandozzi on 7/5/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

#import "JBMMovieController.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const baseURLString = @"https://api.themoviedb.org/3/search/movie";
static NSString * const apiKey = @"18abaabe4391bdf77d1c6ee1a79a24dc";
static NSString * const posterPath = @"https://image.tmdb.org/t/p/original";
static NSString * const apiString = @"api_key";
static NSString * const queryString = @"query";


@implementation JBMMovieController

+ (instancetype)sharedInstance
{
    static JBMMovieController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [JBMMovieController new];
    });
    return sharedInstance;
}

- (void)fetchMovieWithSearch:(NSString *)search completion:(void (^)(NSArray<JBMMovie *> * _Nonnull))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *apiKeyItem = [[NSURLQueryItem alloc]initWithName:apiString value:apiKey];
    NSURLQueryItem *searchTerm = [[NSURLQueryItem alloc]initWithName:queryString value:search];
    urlComponents.queryItems = @[apiKeyItem, searchTerm];
    
    NSURL *finalURL = urlComponents.URL;
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an issue with the URL: %@, %@", [error localizedDescription], error);
            completion(nil);
            return;
        }
        if (data)
        {
            NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
            NSArray *resultsArray = topLevelDictionary[@"results"];
            if (!topLevelDictionary)
            {
                NSLog(@"Error Parsing JSON: %@, %@", [error localizedDescription], error);
                completion(nil);
                return;
            }
            NSMutableArray *tempMovieArray = [NSMutableArray new];
            for (NSDictionary *movieDictionary in resultsArray)
            {
                JBMMovie *movie = [[JBMMovie alloc] initWithDictionary:movieDictionary];
                [tempMovieArray addObject:movie];
                completion(tempMovieArray);
            }
        }
    }] resume];
}

//- (void)fetchImage:(JBMMovie *)movieToFetchImage completion:(void (^)(UIImage * _Nonnull))completion
//{
//    NSURL *imageURL = [NSURL URLWithString:movieToFetchImage.image];
//    NSURL *finalImageURL = [imageURL URLByAppendingPathComponent:posterPath];
//    NSLog(@"%@", finalImageURL);
//    
//    [[[NSURLSession sharedSession] dataTaskWithURL:finalImageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"Error fetching the image for post: %@", error);
//            completion(nil);
//            return;
//        }
//        if (!data) {
//            NSLog(@"Error with fetched image data");
//            completion(nil);
//            return;
//        }
//        UIImage *moviePoster = [UIImage imageWithData:data];
//        completion(moviePoster);
//    }] resume];
//}


@end
NS_ASSUME_NONNULL_END
