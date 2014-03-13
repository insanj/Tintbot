#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

/************************** Navigation Bar Tinting **************************/

// UINavigationBar defaults:
// barStyle = 0
// barTintColor (light theme) = UIDeviceWhiteColorSpace 0.960784 1
// barTintColor (dark theme)  = UIDeviceWhiteColorSpace 0.301961 1
// tintColor (light theme) = UIDeviceRGBColorSpace 0 0.478431 1 1
// tintColor (dark theme)  = UIDeviceRGBColorSpace 0.4 0.690196 1 1
// translucent = NO
// alpha = 1

%hook UINavigationBar

- (void)layoutSubviews {
	%orig();

	NSLog(@"[Tintbot] Detected UINavigation -layoutSubviews, tinting properly...");

	self.translucent = YES;

	// Dark Theme
	if(CGColorGetComponents([self.tintColor CGColor])[0] > 0) {
		self.barStyle = UIBarStyleBlack;
		self.barTintColor = nil;
	}

	// Light Theme
	else {
		self.barStyle = UIBarStyleDefault;
		self.barTintColor = [UIColor clearColor];
	}
}

%end

/**************************** Table Cell Tinting ****************************/

@interface PTHTweetbotCursorController
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
@end

@interface PTHTweetbotStatusCell : UITableViewCell
@property (nonatomic,copy) UIView *statusView;
@end

%hook PTHTweetbotCursorController

- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2 {
	PTHTweetbotStatusCell *cell = %orig();

	CGFloat whiteValue;
	if (![cell.statusView.backgroundColor getWhite:&whiteValue alpha:nil] || whiteValue <= 0.2) {
		cell.statusView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.9];
	}

	return cell;
}

%end

/****************************** TabBar Tinting ******************************/

// UITabBar defaults:
// barStyle = 0
// barTintColor = UIDeviceWhiteColorSpace 0.101961 1
// tintColor (light theme) = UIDeviceRGBColorSpace 0 0.478431 1 1
// tintColor (dark theme)  = UIDeviceRGBColorSpace 0.4 0.690196 1 1
// translucent = YES
// alpha = 1

%hook UITabBar

- (void)layoutSubviews {
	%orig();

	NSLog(@"[Tintbot] Detected UITabBar -layoutSubviews, tinting properly...");

	// Dark Theme
	if(CGColorGetComponents([self.tintColor CGColor])[0] > 0) {
		self.barStyle = UIBarStyleBlack;
		self.barTintColor = nil;
	}

	// Light Theme
	else {
		self.barStyle = UIBarStyleDefault;
		self.barTintColor = [UIColor clearColor];
	}
}

%end
