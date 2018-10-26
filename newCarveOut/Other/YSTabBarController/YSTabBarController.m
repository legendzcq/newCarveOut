//
//  YSTabBarController.m
//  YSTabBarController
//
//  Created by yangshuai on 2017/8/24.
//  Copyright © 2017年 daniel. All rights reserve
//

#import "YSTabBarController.h"
#import <objc/runtime.h>

#define TAB_BAR_HEIGHT TabbarHeight

#pragma mark - YSTabContentScrollView

/**
 *  自定义UIScrollView，在需要时可以拦截其滑动手势
 */

@class YSTabContentScrollView;

@protocol YSTabContentScrollViewDelegate <NSObject>

@optional

- (BOOL)scrollView:(YSTabContentScrollView *)scrollView shouldScrollToPageIndex:(NSUInteger)index;

@end

@interface YSTabContentScrollView : UIScrollView

@property (nonatomic, weak) id<YSTabContentScrollViewDelegate> ys_delegate;

@property (nonatomic, assign) BOOL interceptLeftSlideGuetureInLastPage;
@property (nonatomic, assign) BOOL interceptRightSlideGuetureInFirstPage;

@end


#pragma mark - UIViewController (YSTabBarController)

@implementation UIViewController (YSTabBarController)

- (NSString *)ys_tabItemTitle {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setYs_tabItemTitle:(NSString *)ys_tabItemTitle{
    self.ys_tabItem.title = ys_tabItemTitle;
    objc_setAssociatedObject(self, @selector(ys_tabItemTitle), ys_tabItemTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);

}
- (UIImage *)ys_tabItemImage {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setYs_tabItemImage:(UIImage *)ys_tabItemImage {
    self.ys_tabItem.image = ys_tabItemImage;
    objc_setAssociatedObject(self, @selector(ys_tabItemImage), ys_tabItemImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)ys_tabItemSelectedImage {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setYs_tabItemSelectedImage:(UIImage *)ys_tabItemSelectedImage {
    self.ys_tabItem.selectedImage = ys_tabItemSelectedImage;
    objc_setAssociatedObject(self, @selector(ys_tabItemSelectedImage), ys_tabItemSelectedImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YSTabItem *)ys_tabItem {
    YSTabBar *tabBar = self.ys_tabBarController.tabBar;
    if (!tabBar) {
        return nil;
    }
    if (![self.ys_tabBarController.viewControllers containsObject:self]) {
        return nil;
    }
    
    NSUInteger index = [self.ys_tabBarController.viewControllers indexOfObject:self];
    return tabBar.items[index];
}

- (YSTabBarController *)ys_tabBarController {
    return (YSTabBarController *)self.parentViewController;
}

- (void)ys_tabItemDidSelected:(BOOL)isFirstTime {}

- (void)tabItemDidSelected {}

- (void)ys_tabItemDidDeselected {}

- (void)tabItemDidDeselected {}

- (BOOL)ys_isTabItemSelectedFirstTime {
    id selected = objc_getAssociatedObject(self, _cmd);
    if (!selected) {
        return YES;
    }
    return [selected boolValue];
}

@end


#pragma mark - YSTabBarController

@interface YSTabBarController () <UIScrollViewDelegate, YSTabContentScrollViewDelegate> {
    BOOL _didViewAppeared;
    CGFloat _lastContentScrollViewOffsetX;
}

@property (nonatomic, strong) YSTabContentScrollView *contentScrollView;

@property (nonatomic, assign) BOOL contentScrollEnabled;
@property (nonatomic, assign) BOOL contentSwitchAnimated;

@end

@implementation YSTabBarController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _setup];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)_setup {
    _selectedControllerIndex = NSNotFound;
    _tabBar = [[YSTabBar alloc] init];
    _tabBar.delegate = self;
    
    _loadViewOfChildContollerWhileAppear = NO;
    _defaultSelectedControllerIndex = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupFrameOfTabBarAndContentView];
    
    [self.view addSubview:self.tabBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 在第一次调用viewWillAppear方法时，初始化选中的item
    if (!_didViewAppeared) {
        self.tabBar.selectedItemIndex = self.defaultSelectedControllerIndex;
        _didViewAppeared = YES;
    }
}

- (void)setupFrameOfTabBarAndContentView {
    // 设置默认的tabBar的frame和contentViewFrame
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    CGFloat contentViewY = 0;
    CGFloat tabBarY = screenSize.height - TAB_BAR_HEIGHT;
    CGFloat contentViewHeight = tabBarY;
    // 如果parentViewController为UINavigationController及其子类
    if ([self.parentViewController isKindOfClass:[UINavigationController class]] &&
        !self.navigationController.navigationBarHidden &&
        !self.navigationController.navigationBar.hidden) {
        
        CGFloat navMaxY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        if (!self.navigationController.navigationBar.translucent ||
            self.edgesForExtendedLayout == UIRectEdgeNone ||
            self.edgesForExtendedLayout == UIRectEdgeTop) {
            tabBarY = screenSize.height - TAB_BAR_HEIGHT - navMaxY;
            contentViewHeight = tabBarY;
        } else {
            contentViewY = navMaxY;
            contentViewHeight = screenSize.height - TAB_BAR_HEIGHT - contentViewY;
        }
    }
#pragma  mark ---适配iPhone X修改
    //    [self setTabBarFrame:CGRectMake(0, tabBarY, screenSize.width, TAB_BAR_HEIGHT)
    //        contentViewFrame:CGRectMake(0, contentViewY, screenSize.width, contentViewHeight)];
    [self setTabBarFrame:CGRectMake(0, tabBarY, screenSize.width, 50)
        contentViewFrame:CGRectMake(0, contentViewY, screenSize.width, contentViewHeight)];
}

- (void)setContentViewFrame:(CGRect)contentViewFrame {
    _contentViewFrame = contentViewFrame;
    [self updateContentViewsFrame];
}

- (void)setTabBarFrame:(CGRect)tabBarFrame contentViewFrame:(CGRect)contentViewFrame {
    self.tabBar.frame = tabBarFrame;
    self.contentViewFrame = contentViewFrame;
}

- (void)setViewControllers:(NSArray *)viewControllers {
    for (UIViewController *controller in _viewControllers) {
        [controller removeFromParentViewController];
        if (controller.isViewLoaded) {
            [controller.view removeFromSuperview];
        }
    }
    
    _viewControllers = [viewControllers copy];
    
    NSMutableArray *items = [NSMutableArray array];
    for (UIViewController *controller in _viewControllers) {
        [self addChildViewController:controller];
        
        YSTabItem *item = [YSTabItem buttonWithType:UIButtonTypeCustom];
        item.image = controller.ys_tabItemImage;
        item.selectedImage = controller.ys_tabItemSelectedImage;
        item.title = controller.ys_tabItemTitle;
        [items addObject:item];
    }
    self.tabBar.items = items;
    
    if (_didViewAppeared) {
        _selectedControllerIndex = NSNotFound;
        self.tabBar.selectedItemIndex = 0;
    }
    
    // 更新scrollView的content size
    if (self.contentScrollView) {
        self.contentScrollView.contentSize = CGSizeMake(self.contentViewFrame.size.width * _viewControllers.count,
                                                 self.contentViewFrame.size.height);
    }
}

- (void)setContentScrollEnabledAndTapSwitchAnimated:(BOOL)switchAnimated {
    if (!self.contentScrollView) {
        self.contentScrollView = [[YSTabContentScrollView alloc] initWithFrame:self.contentViewFrame];
        self.contentScrollView.pagingEnabled = YES;
        self.contentScrollView.showsHorizontalScrollIndicator = NO;
        self.contentScrollView.showsVerticalScrollIndicator = NO;
        self.contentScrollView.scrollsToTop = NO;
        self.contentScrollView.delegate = self;
        self.contentScrollView.ys_delegate = self;
        [self.view insertSubview:self.contentScrollView belowSubview:self.tabBar];
        self.contentScrollView.contentSize = CGSizeMake(self.contentViewFrame.size.width * self.viewControllers.count, self.contentViewFrame.size.height);
    }
    [self updateContentViewsFrame];
    self.contentSwitchAnimated = switchAnimated;
}

- (void)updateContentViewsFrame {
    if (self.contentScrollView) {
        self.contentScrollView.frame = self.contentViewFrame;
        self.contentScrollView.contentSize = CGSizeMake(self.contentViewFrame.size.width * self.viewControllers.count,
                                                 self.contentViewFrame.size.height);
        [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull controller,
                                                           NSUInteger idx, BOOL * _Nonnull stop) {
            if (controller.isViewLoaded) {
                controller.view.frame = [self frameForControllerAtIndex:idx];
            }
        }];
        [self.contentScrollView scrollRectToVisible:self.selectedController.view.frame animated:NO];
    } else {
        self.selectedController.view.frame = self.contentViewFrame;
    }
}

- (CGRect)frameForControllerAtIndex:(NSUInteger)index {
    return CGRectMake(index * self.contentViewFrame.size.width,
                      0,
                      self.contentViewFrame.size.width,
                      self.contentViewFrame.size.height);
}

- (void)setInterceptRightSlideGuetureInFirstPage:(BOOL)interceptRightSlideGuetureInFirstPage {
    _interceptRightSlideGuetureInFirstPage = interceptRightSlideGuetureInFirstPage;
    self.contentScrollView.interceptRightSlideGuetureInFirstPage = interceptRightSlideGuetureInFirstPage;
}

- (void)setInterceptLeftSlideGuetureInLastPage:(BOOL)interceptLeftSlideGuetureInLastPage {
    _interceptLeftSlideGuetureInLastPage = interceptLeftSlideGuetureInLastPage;
    self.contentScrollView.interceptLeftSlideGuetureInLastPage = interceptLeftSlideGuetureInLastPage;
}

- (void)setSelectedControllerIndex:(NSUInteger)selectedControllerIndex {
    self.tabBar.selectedItemIndex = selectedControllerIndex;
}

- (UIViewController *)selectedController {
    if (self.selectedControllerIndex != NSNotFound) {
        return self.viewControllers[self.selectedControllerIndex];
    }
    return nil;
}

- (void)didSelectViewControllerAtIndex:(NSUInteger)index {}

#pragma mark - YSTabBarDelegate

- (void)ys_tabBar:(YSTabBar *)tabBar didSelectedItemAtIndex:(NSUInteger)index {
    if (index == self.selectedControllerIndex) {
        return;
    }
    UIViewController *oldController = nil;
    if (self.selectedControllerIndex != NSNotFound) {
        oldController = self.viewControllers[self.selectedControllerIndex];
        [oldController ys_tabItemDidDeselected];
        if ([oldController respondsToSelector:@selector(tabItemDidDeselected)]) {
            [oldController performSelector:@selector(tabItemDidDeselected)];
        }
        [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull controller, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx != index && controller.isViewLoaded && controller.view.superview) {
                [controller.view removeFromSuperview];
            }
        }];
    }
    UIViewController *curController = self.viewControllers[index];
    if (self.contentScrollView) {
        // contentView支持滚动
        if (!curController.isViewLoaded) {
            curController.view.frame = [self frameForControllerAtIndex:index];
        }
        
        [self.contentScrollView addSubview:curController.view];
        // 切换到curController
        [self.contentScrollView scrollRectToVisible:curController.view.frame animated:self.contentSwitchAnimated];
    } else {
        // contentView不支持滚动
        
        [self.view insertSubview:curController.view belowSubview:self.tabBar];
        // 设置curController.view的frame
        if (!CGRectEqualToRect(curController.view.frame, self.contentViewFrame)) {
            curController.view.frame = self.contentViewFrame;
        }
    }
    
    BOOL isSelectedFirstTime = [curController ys_isTabItemSelectedFirstTime];
    if (isSelectedFirstTime) {
        objc_setAssociatedObject(curController, @selector(ys_isTabItemSelectedFirstTime), @(NO), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [curController ys_tabItemDidSelected:isSelectedFirstTime];
    if ([curController respondsToSelector:@selector(tabItemDidSelected)]) {
        [curController performSelector:@selector(tabItemDidSelected)];
    }
    
    // 当contentView为scrollView及其子类时，设置它支持点击状态栏回到顶部
    if (oldController && [oldController.view isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)oldController.view setScrollsToTop:NO];
    }
    if ([curController.view isKindOfClass:[UIScrollView class]]) {
        [(UIScrollView *)curController.view setScrollsToTop:YES];
    }

    _selectedControllerIndex = index;
    
    [self didSelectViewControllerAtIndex:_selectedControllerIndex];
}

#pragma mark - YSTabContentScrollViewDelegate

- (BOOL)scrollView:(YSTabContentScrollView *)scrollView shouldScrollToPageIndex:(NSUInteger)index {
    if ([self respondsToSelector:@selector(ys_tabBar:shouldSelectItemAtIndex:)]) {
        return [self ys_tabBar:self.tabBar shouldSelectItemAtIndex:index];
    }
    return YES;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.tabBar.selectedItemIndex = page;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 如果不是手势拖动导致的此方法被调用，不处理
    if (!(scrollView.isDragging || scrollView.isDecelerating)) {
        return;
    }
    
    // 滑动越界不处理
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat scrollViewWidth = scrollView.frame.size.width;
    
    if (offsetX < 0) {
        return;
    }
    if (offsetX > scrollView.contentSize.width - scrollViewWidth) {
        return;
    }

    NSUInteger leftIndex = offsetX / scrollViewWidth;
    NSUInteger rightIndex = leftIndex + 1;
    
    // 这里处理shouldSelectItemAtIndex方法
    if ([self respondsToSelector:@selector(ys_tabBar:shouldSelectItemAtIndex:)] && !scrollView.isDecelerating) {
        NSUInteger targetIndex;
        if (_lastContentScrollViewOffsetX < (CGFloat)offsetX) {
            // 向左
            targetIndex = rightIndex;
        } else {
            // 向右
            targetIndex = leftIndex;
        }
        if (targetIndex != self.selectedControllerIndex) {
            if (![self ys_tabBar:self.tabBar shouldSelectItemAtIndex:targetIndex]) {
                [scrollView setContentOffset:CGPointMake(self.selectedControllerIndex * scrollViewWidth, 0) animated:NO];
            }
        }
    }
    _lastContentScrollViewOffsetX = offsetX;
    
    // 刚好处于能完整显示一个child view的位置
    if (leftIndex == offsetX / scrollViewWidth) {
        rightIndex = leftIndex;
    }
    // 将需要显示的child view放到scrollView上
    for (NSUInteger index = leftIndex; index <= rightIndex; index++) {
        UIViewController *controller = self.viewControllers[index];
        
        if (!controller.isViewLoaded && self.loadViewOfChildContollerWhileAppear) {
            controller.view.frame = [self frameForControllerAtIndex:index];
        }
        if (controller.isViewLoaded && !controller.view.superview) {
            [self.contentScrollView addSubview:controller.view];
        }
    }
    
    // 同步修改tarBar的子视图状态
    [self.tabBar updateSubViewsWhenParentScrollViewScroll:self.contentScrollView];
}

@end


@implementation YSTabContentScrollView

/**
 *  重写此方法，在需要的时候，拦截UIPanGestureRecognizer
 */
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if (![gestureRecognizer respondsToSelector:@selector(translationInView:)]) {
        return YES;
    }
    // 计算可能切换到的index
    NSInteger currentIndex = self.contentOffset.x / self.frame.size.width;
    NSInteger targetIndex = currentIndex;
    
    CGPoint translation = [gestureRecognizer translationInView:self];
    if (translation.x > 0) {
        targetIndex = currentIndex - 1;
    } else {
        targetIndex = currentIndex + 1;
    }
    
    // 第一页往右滑动
    if (self.interceptRightSlideGuetureInFirstPage && targetIndex < 0) {
        return NO;
    }
    
    // 最后一页往左滑动
    if (self.interceptLeftSlideGuetureInLastPage) {
        NSUInteger numberOfPage = self.contentSize.width / self.frame.size.width;
        if (targetIndex >= numberOfPage) {
            return NO;
        }
    }
    
    // 其他情况
    if (self.ys_delegate && [self.ys_delegate respondsToSelector:@selector(scrollView:shouldScrollToPageIndex:)]) {
        return [self.ys_delegate scrollView:self shouldScrollToPageIndex:targetIndex];
    }
    
    return YES;
}

@end
