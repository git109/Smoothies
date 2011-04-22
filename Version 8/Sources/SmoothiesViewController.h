
#import "EditRecipeViewController.h"

@class DataModel;

/*
 * This is the view controller that lists all smoothie recipes.
 */
@interface SmoothiesViewController : UITableViewController <EditRecipeDelegate>
{
}

// We have a weak reference to the shared Data Model object
@property (nonatomic, assign) IBOutlet DataModel* dataModel;

- (IBAction)addRecipe;

@end
