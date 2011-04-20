
#import "RecipeDetailsViewController.h"
#import "Recipe.h"

@implementation RecipeDetailsViewController

@synthesize imageView, instructionsTextView, recipe;

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = self.recipe.name;
	self.imageView.image = self.recipe.image;
	self.instructionsTextView.text = self.recipe.instructions;
}

- (void)viewDidUnload
{
	self.imageView = nil;
	self.instructionsTextView = nil;
	[super viewDidUnload];
}

- (void)dealloc
{
	[imageView release];
	[instructionsTextView release];
	[recipe release];
	[super dealloc];
}

@end
