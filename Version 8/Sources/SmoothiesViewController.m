
#import "SmoothiesViewController.h"
#import "DataModel.h"
#import "Recipe.h"
#import "RecipeDetailsViewController.h"

@implementation SmoothiesViewController

@synthesize dataModel;

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// Set the height of the table view rows
	self.tableView.rowHeight = 66;

	// Start listening for notifications
	[[NSNotificationCenter defaultCenter] addObserver:self
		selector:@selector(recipesChanged:)
		name:RecipesChangedNotification
		object:nil];
}

- (void)viewDidUnload
{
	[super viewDidUnload];

	// Stop listening for notifications
	[[NSNotificationCenter defaultCenter] removeObserver:self
		name:RecipesChangedNotification
		object:nil];
}

- (void)dealloc
{
	// Stop listening for notifications
	[[NSNotificationCenter defaultCenter] removeObserver:self
		name:RecipesChangedNotification
		object:nil];

	[super dealloc];
}

- (void)recipesChanged:(NSNotification*)notification
{
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Actions

- (IBAction)addRecipe
{
	// Create the Add Recipe screen and show it modally
	EditRecipeViewController* controller = [[EditRecipeViewController alloc] init];
	controller.delegate = self;
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView*)theTableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of recipes in our list
	return [self.dataModel recipeCount];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	static NSString* CellIdentifier = @"RecipeCellIdentifier";

	// Obtain a table view cell for this row
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

	// Get the Recipe object from the list
	Recipe* recipe = [self.dataModel recipeAtIndex:indexPath.row];

	// Put the Recipe data into the cell
	cell.textLabel.text = recipe.name;
	cell.imageView.image = recipe.image;

	return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
	// Create the Recipe Details screen
	RecipeDetailsViewController* controller = [[RecipeDetailsViewController alloc] init];
	controller.dataModel = self.dataModel;

	// Tell the Recipe Details screen which Recipe it should display
	Recipe* recipe = [self.dataModel recipeAtIndex:indexPath.row];
	controller.recipe = recipe;

	// Show the Recipe Details screen
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

- (void)tableView:(UITableView*)theTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
	// Remove the Recipe from our data model
	[self.dataModel removeRecipeAtIndex:indexPath.row];

	// Remove the row from the table with an animation
	[theTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark -
#pragma mark EditRecipeDelegate

- (void)editRecipeDidSave:(EditRecipeViewController*)controller
{
	// Create a new Recipe object with the values from the controller
	// and add it to the data model
	Recipe* recipe = [[Recipe alloc] init];
	recipe.name = controller.name;
	recipe.instructions = controller.instructions;
	recipe.image = controller.image;
	[self.dataModel addRecipe:recipe];
	[recipe release];

	// Refresh the table
	[self.tableView reloadData];
}

@end
