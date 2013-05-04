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
@property (strong, nonatomic) NSString *isbn;
@property (strong, nonatomic) NSString *publisher;
@property (strong, nonatomic) NSDictionary *rawData;

@end
