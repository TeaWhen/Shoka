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
@property (strong, nonatomic) NSString *publisher;
@property (nonatomic) NSInteger publishYear;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *translator;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *subject;
@property (nonatomic) NSInteger pages;
@property (strong, nonatomic) NSMutableDictionary *extraInfo;

@end
