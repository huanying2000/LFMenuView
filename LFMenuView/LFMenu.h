//
//  LFMenu.h
//  LFMenuView
//
//  Created by Mac on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LFMenuLeftNavBar,
    LFMenuRightNavBar,
    LFMenuLeftNormal,
    LFMenuMidNormal,
    LFMenuRightNormal,
}LFMenuType;

typedef void(^ItemClickIndexBlock)(NSInteger index);

@interface LFMenu : UIView


/**
 展示菜单到View
 
 @param imagesArr 图片
 @param titles 标题
 @param view 作用的View
 @param menuType 菜单类型
 @param block 回调Block
 */
+ (void)showMenuWithImages:(NSArray *)imagesArr titles:(NSArray *)titles inView:(UIView *)view menuType:(LFMenuType)menuType withItemClickIndex:(ItemClickIndexBlock)block;

/**
 展示菜单到当前的navigationVC
 
 @param imagesArr 图片
 @param titles 标题
 @param menuType 菜单类型
 @param currentNavVC 展示当前的navigationVC
 @param block 回调block
 */
+ (void)showMenuWithImages:(NSArray *)imagesArr titles:(NSArray *)titles menuType:(LFMenuType)menuType currentNavVC:(UINavigationController *)currentNavVC withItemClickIndex:(ItemClickIndexBlock)block;

/**
 隐藏菜单
 @param view 当前的View
 */
+ (void)dismissMenuInView:(UIView *)view;

@end
