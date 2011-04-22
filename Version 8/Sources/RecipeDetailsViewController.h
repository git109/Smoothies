
#import "EditRecipeViewController.h"

@class DataModel;
@class Recipe;

/*
 * This screen shows additional information about a recipe.
 */
@interface RecipeDetailsViewController : UIViewController <EditRecipeDelegate>
{
}

@property (nonatomic, retain) IBOutlet UIImageView* imageView;
@property (nonatomic, retain) IBOutlet UITextView* instructionsTextView;
@property (nonatomic, retain) IBOutlet UIButton* favoriteButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* editButton;

// The data model object
@property (nonatomic, assign) DataModel* dataModel;

// The recipe that we will be showing
@property (nonatomic, retain) Recipe* recipe;

- (IBAction)favoriteTapped;
- (IBAction)editRecipe;

@end
