//
//  ShokaGrayView.m
//  Shoka
//
//  Created by Xhacker on 2013-05-09.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaGrayView.h"

@implementation ShokaGrayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setGray:(BOOL)gray withDuration:(NSTimeInterval)duration
{
    if (gray) {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = 0.5;
        } completion:nil];
    }
    else {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha = 0;
        } completion:nil];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
