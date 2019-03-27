//
//  BeeCustomButton.m
//  MFSC
//
//  Created by leaf on 2018/1/17.
//  Copyright © 2018年 LRG. All rights reserved.
//

#import "BeeCustomButton.h"

@implementation BeeCustomButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addTarget:self action:@selector(clickSelf:) forControlEvents:UIControlEventTouchUpInside];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;

    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    switch (_type) {
        case type_textOnTop_IconOnBottom:
             return CGRectMake(0, CGRectGetHeight(self.frame) * 0.4, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) * 0.6);
        case type_textOnBottom_IconOnTop:
            return CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) * 0.6);
        case type_textOnRight_IconOnLeft:
            return CGRectMake(0, 0, contentRect.size.width * 0.4 , contentRect.size.height);
        case type_textOnLeft_IconOnRight:
            return CGRectMake(contentRect.size.width * 0.6, CGRectGetHeight(self.frame) * 0.5 - (contentRect.size.height * 0.4) * 0.5, contentRect.size.width * 0.4 , contentRect.size.height * 0.4);
        default:
            return contentRect;
    }
    return contentRect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {

    switch (_type) {
        case type_textOnTop_IconOnBottom:
            return CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) * 0.4);
        case type_textOnBottom_IconOnTop:
            return CGRectMake(0, CGRectGetHeight(self.frame) * 0.6, CGRectGetWidth(self.frame),CGRectGetHeight(self.frame) * 0.4);
        case type_textOnRight_IconOnLeft:
            return CGRectMake(CGRectGetWidth(self.frame) * 0.4, 0, contentRect.size.width * 0.6 , contentRect.size.height);
        case type_textOnLeft_IconOnRight:
            return CGRectMake(0, 0, CGRectGetWidth(self.frame) * 0.6, CGRectGetHeight(self.frame));
        default:
            return contentRect;
    }
    return contentRect;

}

- (void)clickSelf:(UIButton*)sender {
    if (_clickButton) {
        _clickButton(sender);
    }
}
- (void)clickButton:(void (^)(UIButton *))sender {
    
    _clickButton = ^(UIButton *objcButton) {
        sender(objcButton);
    };
}
@end
