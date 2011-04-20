
#import "RecipeDetailsViewController.h"
#import "DataModel.h"
#import "Recipe.h"

@implementation RecipeDetailsViewController

@synthesize imageView, instructionsTextView, favoriteButton, dataModel, recipe;

- (void)updateFavoriteButton
{
	NSString* title;
	if ([self.dataModel isFavorite:self.recipe])
		title = @"√ Favorite";
	else
		title = @"Favorite";

	[self.favoriteButton setTitle:title forState:UIControlStateNormal];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = self.recipe.name;
	self.imageView.image = self.recipe.image;
	self.instructionsTextView.text = self.recipe.instructions;
	
	// Set the button to the proper initial state
	[self updateFavoriteButton];
}

- (void)viewDidUnload
{
	self.imageView = nil;
	self.instructionsTextView = nil;
	self.favoriteButton = nil;
	[super viewDidUnload];
}

- (void)dealloc
{
	[imageView release];
	[instructionsTextView release];
	[favoriteButton release];
	[recipe release];
	[super dealloc];
}

- (IBAction)favoriteTapped
{
	// Check to see if the name of our recipe is in the list of favorites
	if ([self.dataModel isFavorite:self.recipe])
	{
		// Remove this recipe's name from the list of favorites
		[self.dataModel removeFromFavorites:self.recipe];
	}
	else
	{
		// Add this recipe's name to the list of favorites
		[self.dataModel addToFavorites:self.recipe];
	}

	// Update the toggle state of the button
	[self updateFavoriteButton];
}

@end
