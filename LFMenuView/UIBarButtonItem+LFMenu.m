//
//  UIBarButtonItem+LFMenu.m
//  LFMenuView
//
//  Created by Mac on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UIBarButtonItem+LFMenu.h"

@implementation UIBarButtonItem (LFMenu)


- (void)lf_showMenuWithImages:(NSArray *)imagesArr titles:(NSArray *)titles menuType:(LFMenuType)menuType currentNavVC:(UINavigationController *)currentNavVC withItemClickIndex:(ItemClickIndexBlock)block
{
    [LFMenu showMenuWithImages:imagesArr titles:titles menuType:menuType currentNavVC:currentNavVC withItemClickIndex:block];
}

@end
