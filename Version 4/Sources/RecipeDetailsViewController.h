
@class Recipe;

/*
 * This screen shows additional information about a recipe.
 */
@interface RecipeDetailsViewController : UIViewController
{
}

@property (nonatomic, retain) IBOutlet UIImageView* imageView;
@property (nonatomic, retain) IBOutlet UITextView* instructionsTextView;

// The recipe that we will be showing
@property (nonatomic, retain) Recipe* recipe;

@end
