//
//  ShokaBook.h
//  Shoka
//
//  Created by Xhacker on 2013-05-03.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShokaBook : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *ISBN;
@property (strong, nonatomic) NSString *pages;
@property (strong, nonatomic) NSString *publisher;
@property (strong, nonatomic) NSString *publishDate;
@property (strong, nonatomic) NSString *summary;

@property (strong, nonatomic) NSArray *authors;
@property (strong, nonatomic) NSArray *translators;
@property (strong, nonatomic) NSArray *subjects;

@property (strong, nonatomic) NSMutableDictionary *extraInfo;

@end
