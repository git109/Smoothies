
#import "SmoothiesAppDelegate.h"
#import "DataModel.h"
#import "SmoothiesViewController.h"
#import "FavoritesViewController.h"

@implementation SmoothiesAppDelegate

@synthesize window, tabBarController, smoothiesViewController,
			favoritesViewController, dataModel;

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
	// Create the Data Model object
	self.dataModel = [[DataModel alloc] init];

	// Tell the view controllers about the Data Model
	self.smoothiesViewController.dataModel = self.dataModel;
	self.favoritesViewController.dataModel = self.dataModel;

	[self.window addSubview:self.tabBarController.view];
	[self.window makeKeyAndVisible];
	return YES;
}

- (void)dealloc
{
	[window release];
	[tabBarController release];
	[smoothiesViewController release];
	[favoritesViewController release];
	[dataModel release];
	[super dealloc];
}

@end
