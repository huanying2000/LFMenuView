//
//  UIBarButtonItem+LFMenu.h
//  LFMenuView
//
//  Created by Mac on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFMenu.h"

@interface UIBarButtonItem (LFMenu)

/**
 NavBarItem Show XYMenu
 @param imagesArr 图片
 @param titles 标题
 @param menuType 菜单类型(XYMenuLeftNavBar,XYMenuRightNavBar)
 @param currentNavVC BarItem所在的NavVC
 @param block 回调Block
 */
- (void)lf_showMenuWithImages:(NSArray *)imagesArr titles:(NSArray *)titles menuType:(LFMenuType)menuType currentNavVC:(UINavigationController *)currentNavVC withItemClickIndex:(ItemClickIndexBlock)block;

@end
