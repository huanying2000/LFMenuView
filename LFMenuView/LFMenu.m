//
//  LFMenu.m
//  LFMenuView
//
//  Created by Mac on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "LFMenu.h"
#import "LFMenuView.h"

#define kLFMenuScreenWidth [UIScreen mainScreen].bounds.size.width
#define kLFMenuScreenHeight [UIScreen mainScreen].bounds.size.height

static const CGFloat LFMenuWidth = 120; // Menu宽度
static const CGFloat LFMenuItemHeight = 60; // item高度


@interface LFMenu () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) LFMenuView *menuView;
@property (nonatomic, assign) LFMenuType menuType;
@property (nonatomic, assign) CGRect menuInitRect;
@property (nonatomic, assign) CGRect menuResultRect;
@property (nonatomic, assign) BOOL isDismiss;
@property (nonatomic, assign) BOOL isDown;

@end

@implementation LFMenu

- (instancetype)init
{
    if (self = [super init]) {
        _isDismiss = NO;
        _isDown = YES;
        // 添加pan手势, 防止视图响应scrollview的滚动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
        self.frame = CGRectMake(0, 0, kLFMenuScreenWidth, kLFMenuScreenHeight);
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.menuView];
    }
    return self;
}

- (void)panAction:(UIPanGestureRecognizer *)pan{
    if ([pan.view isKindOfClass:[LFMenu class]]) {
        return ;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (![self isInMenuViewWithPoint:point]) {
        [self dismissLFMenu];
    }
    return [super hitTest:point withEvent:event];
}

- (BOOL)isInMenuViewWithPoint:(CGPoint)point
{
    NSArray *subViews = self.subviews;
    for (UIView *subView in subViews) {
        if ([subView isKindOfClass:[LFMenuView class]]) {
            LFMenuView *menuView = (LFMenuView *)subView;
            CGPoint menuVPoint = [self convertPoint:point toView:menuView];
            BOOL isInMenu = [menuView pointInside:menuVPoint withEvent:nil];
            return isInMenu;
        }
    }
    return NO;
}

#pragma mark --- 展示菜单
+ (void)showMenuWithImages:(NSArray *)imagesArr titles:(NSArray *)titles inView:(UIView *)view menuType:(LFMenuType)menuType withItemClickIndex:(ItemClickIndexBlock)block
{
    LFMenu *xy_menu = [[LFMenu alloc] init];
    [xy_menu showMenuWithImages:imagesArr titles:titles inView:view menuType:menuType withItemClickIndex:block];
}

+ (void)showMenuWithImages:(NSArray *)imagesArr titles:(NSArray *)titles menuType:(LFMenuType)menuType currentNavVC:(UINavigationController *)currentNavVC withItemClickIndex:(ItemClickIndexBlock)block
{
    LFMenu *xy_menu = [[LFMenu alloc] init];
    [xy_menu showMenuWithImages:imagesArr titles:titles menuType:menuType currentNavVC:currentNavVC withItemClickIndex:block];
}

#pragma mark --- 隐藏菜单

+ (void)dismissMenuInView:(UIView *)view
{
    LFMenu *menu = [LFMenu LFMenuInView:view];
    if (menu) {
        [menu dismissLFMenu];
    }
}

+ (LFMenu *)LFMenuInView:(UIView *)view
{
    UIView *rootView = [LFMenu rootViewFromSubView:view];
    NSArray *subViews = rootView.subviews;
    for (UIView *view in subViews) {
        if ([view isKindOfClass:[LFMenu class]]) {
            LFMenu *menu = (LFMenu *)view;
            return menu;
        }
    }
    return nil;
}

- (void)showMenuWithImages:(NSArray *)imagesArr titles:(NSArray *)titles menuType:(LFMenuType)menuType currentNavVC:(UINavigationController *)currentNavVC  withItemClickIndex:(ItemClickIndexBlock)block
{
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat statusHeight = statusRect.size.height;
    CGFloat navigationBarHeight =  currentNavVC.navigationBar.bounds.size.height;
    CGFloat LFMenuHeight = LFMenuItemHeight * titles.count;
    switch (menuType) {
        case LFMenuLeftNavBar:
        {
            self.menuInitRect = CGRectMake(10 + (LFMenuWidth / 4), statusHeight + navigationBarHeight, 1, 1);
            self.menuResultRect = CGRectMake(10, statusHeight + navigationBarHeight, LFMenuWidth, LFMenuHeight);
        }
            break;
        case LFMenuRightNavBar:
        {
            self.menuInitRect = CGRectMake(kLFMenuScreenWidth - (LFMenuWidth / 4) - 10, statusHeight + navigationBarHeight, 1, 1);
            self.menuResultRect = CGRectMake(kLFMenuScreenWidth - LFMenuWidth - 10, statusHeight + navigationBarHeight, LFMenuWidth, LFMenuHeight);
        }
            break;
        default:
            break;
    }
    [currentNavVC.view addSubview:self];
    [self showAnimateMenuWithImages:imagesArr titles:titles menuType:menuType withBlock:block];
    
}

- (void)showMenuWithImages:(NSArray *)imagesArr titles:(NSArray *)titles inView:(UIView *)view menuType:(LFMenuType)menuType withItemClickIndex:(ItemClickIndexBlock)block
{
    [self configRectWithMenuType:menuType inView:view titles:titles];
    [self showAnimateMenuWithImages:imagesArr titles:titles menuType:menuType withBlock:block];
}

- (void)showAnimateMenuWithImages:(NSArray *)imagesArr titles:(NSArray *)titles menuType:(LFMenuType)menuType withBlock:(ItemClickIndexBlock)block
{
    __weak typeof(self) weakSelf = self;
    [self.menuView setImagesArr:imagesArr titles:titles withRect:self.menuResultRect withMenuType:menuType isDown:_isDown withItemClickBlock:^(NSInteger index) {
        [weakSelf dismissLFMenu];
        block(index);
    }];
    self.menuView.frame = self.menuInitRect;
    [self.menuView hideContentView];
    self.menuView.alpha = 0.1;
    [UIView animateWithDuration:0.1 animations:^{
        self.menuView.alpha = 1.0;
        self.menuView.frame = self.menuResultRect;
    } completion:^(BOOL finished) {
        [self.menuView showContentView];
    }];
}

- (void)dismissLFMenu
{
    
    if (_isDismiss) return;
    _isDismiss = YES;
    [self.menuView hideContentView];
    self.menuView.alpha = 1.0;
    [UIView animateWithDuration:0.2 animations:^{
        self.menuView.frame = self.menuInitRect;
        self.menuView.alpha = 0.1;
    } completion:^(BOOL finished) {
        _isDismiss = NO;
        [self removeFromSuperview];
    }];
}

- (void)configRectWithMenuType:(LFMenuType)menuType inView:(UIView *)view titles:(NSArray *)titles
{
    _menuType = menuType;
    UIView *vcView = [LFMenu rootViewFromSubView:view];
    UIView *superView = view.superview;
    CGRect viewRect = view.frame;
    CGRect viewRectFromWindow = [superView convertRect:viewRect toView:vcView];
    CGFloat midX = CGRectGetMidX(viewRectFromWindow);
    CGFloat maxY = CGRectGetMaxY(viewRectFromWindow);
    CGFloat minY = CGRectGetMinY(viewRectFromWindow);
    CGFloat LFMenuHeight = LFMenuItemHeight * titles.count;
    
    
    //    UIScrollView *viewScrollView = [LFMenu scrollViewFromView:view];
    //    if ((viewScrollView && ((maxY + LFMenuHeight + 5 - viewScrollView.contentOffset.y) > kLFMenuScreenHeight)) || (!viewScrollView && ((maxY + LFMenuHeight + 5) > kLFMenuScreenHeight))) {
    //        _isDown = NO;
    //    }
    
    if ((maxY + LFMenuHeight + 5) > kLFMenuScreenHeight) {
        _isDown = NO;
    }
    
    switch (_menuType) {
        case LFMenuLeftNormal:
        {
            if (_isDown) {
                self.menuInitRect = CGRectMake(midX, maxY, 1, 1);
                self.menuResultRect = CGRectMake(midX - (LFMenuWidth / 4), maxY + 5, LFMenuWidth, LFMenuHeight);
            }else {
                self.menuInitRect = CGRectMake(midX, minY, 1, 1);
                self.menuResultRect = CGRectMake(midX - (LFMenuWidth / 4), minY - 5 - LFMenuHeight, LFMenuWidth, LFMenuHeight);
            }
        }
            break;
        case LFMenuRightNormal:
        {
            if (_isDown) {
                self.menuInitRect = CGRectMake(midX, maxY, 1, 1);
                self.menuResultRect = CGRectMake(midX - (LFMenuWidth * 3 / 4), maxY + 5, LFMenuWidth, LFMenuHeight);
            }else {
                self.menuInitRect = CGRectMake(midX, minY, 1, 1);
                self.menuResultRect = CGRectMake(midX - (LFMenuWidth * 3 / 4), minY - 5 - LFMenuHeight, LFMenuWidth, LFMenuHeight);
            }
            
            break;
        }
        case LFMenuMidNormal:
        {
            if (_isDown) {
                self.menuInitRect = CGRectMake(midX, maxY, 1, 1);
                self.menuResultRect = CGRectMake(midX - (LFMenuWidth / 2), maxY + 5, LFMenuWidth, LFMenuHeight);
            }else {
                self.menuInitRect = CGRectMake(midX, minY, 1, 1);
                self.menuResultRect = CGRectMake(midX - (LFMenuWidth / 2), minY - 5 - LFMenuHeight, LFMenuWidth, LFMenuHeight);
            }
        }
            break;
        default:
        {
            if (_isDown) {
                self.menuInitRect = CGRectMake(midX, maxY, 1, 1);
                self.menuResultRect = CGRectMake(midX - (LFMenuWidth / 2), maxY + 5, LFMenuWidth, LFMenuHeight);
            }else {
                self.menuInitRect = CGRectMake(midX, minY, 1, 1);
                self.menuResultRect = CGRectMake(midX - (LFMenuWidth / 2), minY - 5 - LFMenuHeight, LFMenuWidth, LFMenuHeight);
            }
        }
            break;
    }
    [vcView addSubview:self];
}

- (LFMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[LFMenuView alloc] initWithFrame:CGRectZero];
    }
    return _menuView;
}

+ (UIView *)rootViewFromSubView:(UIView *)view
{
    UIViewController *vc = nil;
    UIResponder *next = view.nextResponder;
    do {
        if ([next isKindOfClass:[UINavigationController class]]) {
            vc = (UIViewController *)next;
            break ;
        }
        next = next.nextResponder;
    } while (next != nil);
    if (vc == nil) {
        next = view.nextResponder;
        do {
            if ([next isKindOfClass:[UIViewController class]] || [next isKindOfClass:[UITableViewController class]]) {
                vc = (UIViewController *)next;
                break ;
            }
            next = next.nextResponder;
        } while (next != nil);
    }
    return vc.view;
}

+ (UIScrollView *)scrollViewFromView:(UIView *)view
{
    UIScrollView *scroView = nil;
    UIResponder *next = view.nextResponder;
    do {
        if ([next isKindOfClass:[UIScrollView class]]) {
            scroView = (UIScrollView *)next;
            break ;
        }
        next = next.nextResponder;
    } while (next != nil);
    return scroView;
}

@end
