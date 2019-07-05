//
//  JBMMovie.h
//  MovieDatabaseOBJC
//
//  Created by Jason Mandozzi on 7/5/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBMMovie : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *overview;
@property (nonatomic, readonly) NSNumber* rating;
//@property (nonatomic, copy, readonly) NSString* image;

- (instancetype)initWithTitle:(NSString *)title
                     overview:(NSString *)overview
                       rating:(NSNumber *)rating;
//                        image:(NSString *)image;

@end

@interface JBMMovie (JSONConvertable)

-(instancetype) initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
