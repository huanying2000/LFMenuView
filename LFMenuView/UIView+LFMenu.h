//
//  UIView+LFMenu.h
//  LFMenuView
//
//  Created by Mac on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFMenu.h"

@interface UIView (LFMenu)


/**
 View Show XYMenu
 @param imagesArr 图片
 @param titles 标题
 @param menuType 菜单类型( XYMenuLeftNormal,XYMenuMidNormal,XYMenuRightNormal)
 @param block 回调Block
 
 */

- (void)lf_showMenuWithImages:(NSArray *)imagesArr titles:(NSArray *)titles menuType:(LFMenuType)menuType withItemClickIndex:(ItemClickIndexBlock)block;


@end
