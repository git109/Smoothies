
@class DataModel;

/*
 * This is the view controller that lists the user's favorite recipes.
 */
@interface FavoritesViewController : UITableViewController
{
}

// We have a weak reference to the shared Data Model object
@property (nonatomic, assign) IBOutlet DataModel* dataModel;

@end
