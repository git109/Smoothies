
#import "SmoothiesAppDelegate.h"

@implementation SmoothiesAppDelegate

@synthesize window, navigationController;

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
	[self.window addSubview:self.navigationController.view];
	[self.window makeKeyAndVisible];
	return YES;
}

- (void)dealloc
{
	[window release];
	[navigationController release];
	[super dealloc];
}

@end
