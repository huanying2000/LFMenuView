//
//  LFMenuView.h
//  LFMenuView
//
//  Created by Mac on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFMenu.h"

static const CGFloat kTriangleLength = 16;
typedef void(^ItemClickBlock)(NSInteger index);

@interface LFMenuView : UIView

- (void)setImagesArr:(NSArray *)imagesArr titles:(NSArray *)titles withRect:(CGRect)rect withMenuType:(LFMenuType)menuType isDown:(BOOL)isDown withItemClickBlock:(ItemClickBlock)block;

- (void)showContentView;

- (void)hideContentView;


@end
