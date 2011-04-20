
#import "RecipeDetailsViewController.h"
#import "Recipe.h"

@implementation RecipeDetailsViewController

@synthesize imageView, instructionsTextView, favoriteButton, recipe;

- (void)updateFavoriteButton
{
	NSString* title;
	NSArray* favorites = [[NSUserDefaults standardUserDefaults] objectForKey:@"Favorites"];
	if ([favorites containsObject:self.recipe.name])
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
	NSArray* favorites = [[NSUserDefaults standardUserDefaults] objectForKey:@"Favorites"];
	if ([favorites containsObject:self.recipe.name])
	{
		// Remove this recipe's name from the list of favorites
		NSMutableArray* newArray = [NSMutableArray arrayWithArray:favorites];
		[newArray removeObject:self.recipe.name];
		[[NSUserDefaults standardUserDefaults] setObject:newArray forKey:@"Favorites"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	else
	{
		// Add this recipe's name to the list of favorites
		NSMutableArray* newArray = [NSMutableArray arrayWithArray:favorites];
		[newArray addObject:self.recipe.name];
		[[NSUserDefaults standardUserDefaults] setObject:newArray forKey:@"Favorites"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}

	// Update the toggle state of the button
	[self updateFavoriteButton];
}

@end
