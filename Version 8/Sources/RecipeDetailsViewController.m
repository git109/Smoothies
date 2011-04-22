
#import "RecipeDetailsViewController.h"
#import "DataModel.h"
#import "Recipe.h"

@implementation RecipeDetailsViewController

@synthesize imageView, instructionsTextView, favoriteButton, editButton,
			dataModel, recipe;

- (void)updateFavoriteButton
{
	NSString* title;
	if ([self.dataModel isFavorite:self.recipe])
		title = @"√ Favorite";
	else
		title = @"Favorite";

	[self.favoriteButton setTitle:title forState:UIControlStateNormal];
}

- (void)updateControls
{
	self.title = self.recipe.name;
	self.imageView.image = self.recipe.image;
	self.instructionsTextView.text = self.recipe.instructions;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.navigationItem.rightBarButtonItem = self.editButton;

	// Set the controls to their proper initial state
	[self updateControls];
	[self updateFavoriteButton];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	self.imageView = nil;
	self.instructionsTextView = nil;
	self.favoriteButton = nil;
	self.editButton = nil;
}

- (void)dealloc
{
	[imageView release];
	[instructionsTextView release];
	[favoriteButton release];
	[editButton release];
	[recipe release];
	[super dealloc];
}

#pragma mark -
#pragma mark Actions

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

- (IBAction)editRecipe
{
	// Create the Edit Recipe screen
	EditRecipeViewController* controller = [[EditRecipeViewController alloc] init];

	// Give it the data from our Recipe
	controller.delegate = self;
	controller.name = self.recipe.name;
	controller.instructions = self.recipe.instructions;
	controller.image = self.recipe.image;

	// And show it modally
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

#pragma mark -
#pragma mark EditRecipeDelegate

- (void)editRecipeDidSave:(EditRecipeViewController*)controller
{
	// Put the values from the Edit Recipe screen back into the Recipe
	self.recipe.name = controller.name;
	self.recipe.instructions = controller.instructions;
	self.recipe.image = controller.image;
	
	// Refresh our UI
	[self updateControls];

	// Tell the data model that we changed the Recipe object
	[self.dataModel didChangeRecipe:self.recipe];
}

@end
