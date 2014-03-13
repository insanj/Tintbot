#import <UIKit/UIKit.h>

/****************************** TabBar Tinting ******************************/

@interface PTHTweetbotAccountController : UITabBarController <UITabBarControllerDelegate>
- (id)initWithAccount:(id)arg1;
@end

%hook PTHTweetbotAccountController

// UITabBar defaults:
// barStyle = 0
//			UIBarStyleDefault
// barTintColor = UIDeviceWhiteColorSpace 0.101961 1
//				[UIColor colorWithWhite:0.101961 alpha:1]
// tintColor = UIDeviceRGBColorSpace 0.4 0.690196 1 1
//			 [UIColor colorWithRed:0.4 green:0.686275 blue:1 alpha:1];
// translucent = YES
// alpha = 1

/*- (id)initWithAccount:(id)arg1 {
	PTHTweetbotAccountController *controller = %orig();
	UITabBar *bar = controller.tabBar;

	bar.barStyle = UIBarStyleBlack;
	bar.barTintColor = [UIColor clearColor];

	NSLog(@"[Tintbot] Detected -init of UITabBarController (%@ with %@), tinting...", controller, controller.tabBar);
	return controller;
}

- (void)colorThemeDidChange {
	%orig();

	NSLog(@"[Tintbot] Detected -colorThemeDidChange, tinting %@...", self.tabBar);
	self.tabBar.barStyle = UIBarStyleBlack;
	self.tabBar.barTintColor = [UIColor clearColor];
}*/

- (void)viewDidLayoutSubviews {
	%orig();

	NSLog(@"[Tintbot] Detected -viewDidLayoutSubviews, tinting %@...", self.tabBar);
	self.tabBar.barTintColor = [UIColor clearColor];
	self.tabBar.barStyle = UIBarStyleBlack;
}

%end
