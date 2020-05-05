//
//  qrTypeView.m
//  FOSAapp1.0
//
//  Created by hs on 2020/5/5.
//  Copyright © 2020 hs. All rights reserved.
//

#import "qrTypeView.h"

@implementation qrTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectBox = [UIImageView new];
        [self addSubview:self.selectBox];
        
        self.qrTypeImgView = [UIImageView new];
        [self addSubview:self.qrTypeImgView];
        
        self.qrCountLabel = [UILabel new];
        self.qrCountLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.qrCountLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    int height = (int) self.bounds.size.height;
    int width  = (int) self.bounds.size.width;
    self.selectBox.frame = CGRectMake(5, 5, width/10, width/10);
    self.selectBox.image = [UIImage imageNamed:@"icon_unselect"];
    
    self.qrTypeImgView.frame = CGRectMake(CGRectGetMaxX(self.selectBox.frame), CGRectGetMaxY(self.selectBox.frame), width*4/5-10, height-width/5-10);
    self.qrTypeImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.qrTypeImgView.clipsToBounds = YES;
    
    self.qrCountLabel.frame = CGRectMake(width/2, CGRectGetMaxY(self.qrTypeImgView.frame), width/2, width/10);
    self.qrCountLabel.text = @"0";
    
}
@end