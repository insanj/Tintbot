#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

/****************************** TabBar Tinting ******************************/

// UITabBar defaults:
// barStyle = 0
//			UIBarStyleDefault
// barTintColor = UIDeviceWhiteColorSpace 0.101961 1
//				[UIColor colorWithWhite:0.101961 alpha:1]
// tintColor (light theme) = UIDeviceRGBColorSpace 0 0.478431 1 1
//			 			  [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1]
// tintColor (dark theme) = UIDeviceRGBColorSpace 0.4 0.690196 1 1
//			 			 [UIColor colorWithRed:0.4 green:0.690196 blue:1 alpha:1]
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
