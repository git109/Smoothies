
@class DataModel;
@class SmoothiesViewController;
@class FavoritesViewController;

/*
 * The application delegate.
 */
@interface SmoothiesAppDelegate : NSObject <UIApplicationDelegate>
{
}

@property (nonatomic, retain) IBOutlet UIWindow* window;
@property (nonatomic, retain) IBOutlet UITabBarController* tabBarController;
@property (nonatomic, retain) IBOutlet SmoothiesViewController* smoothiesViewController;
@property (nonatomic, retain) IBOutlet FavoritesViewController* favoritesViewController;

// The shared Data Model object
@property (nonatomic, retain) DataModel* dataModel;

@end
