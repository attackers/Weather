//
//  BeeCustomButton.h
//  MFSC
//
//  Created by leaf on 2018/1/17.
//  Copyright © 2018年 LRG. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CustomButtonType)  {
    type_textOnTop_IconOnBottom,
    type_textOnBottom_IconOnTop,
    type_textOnLeft_IconOnRight,
    type_textOnRight_IconOnLeft,
    type_default
};
@interface BeeCustomButton : UIButton
@property (nonatomic, assign) CustomButtonType type;

@property (nonatomic, copy) void(^clickButton)(UIButton*);
- (void)clickButton:(void(^)(UIButton *button))sender;
@end
