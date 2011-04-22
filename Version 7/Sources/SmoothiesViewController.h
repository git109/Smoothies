
@class DataModel;

/*
 * This is the view controller that lists all smoothie recipes.
 */
@interface SmoothiesViewController : UITableViewController
{
}

// We have a weak reference to the shared Data Model object
@property (nonatomic, assign) IBOutlet DataModel* dataModel;

@end
