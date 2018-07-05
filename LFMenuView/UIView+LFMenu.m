//
//  UIView+LFMenu.m
//  LFMenuView
//
//  Created by Mac on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UIView+LFMenu.h"

@implementation UIView (LFMenu)

- (void)lf_showMenuWithImages:(NSArray *)imagesArr titles:(NSArray *)titles menuType:(LFMenuType)menuType withItemClickIndex:(ItemClickIndexBlock)block
{
    [LFMenu showMenuWithImages:imagesArr titles:titles inView:self menuType:menuType withItemClickIndex:block];
}

@end
