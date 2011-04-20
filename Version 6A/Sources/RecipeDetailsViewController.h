
@class DataModel;
@class Recipe;

/*
 * This screen shows additional information about a recipe.
 */
@interface RecipeDetailsViewController : UIViewController
{
}

@property (nonatomic, retain) IBOutlet UIImageView* imageView;
@property (nonatomic, retain) IBOutlet UITextView* instructionsTextView;
@property (nonatomic, retain) IBOutlet UIButton* favoriteButton;

// The data model object
@property (nonatomic, assign) DataModel* dataModel;

// The recipe that we will be showing
@property (nonatomic, retain) Recipe* recipe;

// The user pressed the mark/unmark as favorite button.
- (IBAction)favoriteTapped;

@end
