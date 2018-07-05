//
//  LFMenuItem.h
//  LFMenuView
//
//  Created by Mac on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFMenuItem : UIView

- (instancetype)initWithIconName:(NSString *)iconName title:(NSString *)title;

- (void)setUpViewsWithRect:(CGRect)rect;

@end
