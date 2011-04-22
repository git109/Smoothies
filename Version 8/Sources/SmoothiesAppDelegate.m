
#import "SmoothiesAppDelegate.h"

@implementation SmoothiesAppDelegate

@synthesize window, tabBarController;

+ (void)initialize
{
	if ([self class] == [SmoothiesAppDelegate class])
	{
		// Add an empty favorites array to the NSUserDefaults
		NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
			[NSArray array], @"Favorites",
			nil];

		[[NSUserDefaults standardUserDefaults] registerDefaults:dict];
	}
}

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
	[self.window addSubview:self.tabBarController.view];
	[self.window makeKeyAndVisible];
	return YES;
}

- (void)dealloc
{
	[window release];
	[tabBarController release];
	[super dealloc];
}

@end
