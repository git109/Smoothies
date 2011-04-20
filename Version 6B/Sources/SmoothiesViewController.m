
#import "SmoothiesViewController.h"
#import "DataModel.h"
#import "Recipe.h"
#import "RecipeDetailsViewController.h"

@implementation SmoothiesViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// Set the height of the table view rows
	self.tableView.rowHeight = 66;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView*)theTableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of recipes in our list
	return [[DataModel sharedInstance] recipeCount];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	static NSString* CellIdentifier = @"RecipeCellIdentifier";

	// Obtain a table view cell for this row
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

	// Get the Recipe object from the list
	Recipe* recipe = [[DataModel sharedInstance] recipeAtIndex:indexPath.row];

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
	controller.dataModel = [DataModel sharedInstance];

	// Tell the Recipe Details screen which Recipe it should display
	Recipe* recipe = [[DataModel sharedInstance] recipeAtIndex:indexPath.row];
	controller.recipe = recipe;

	// Show the Recipe Details screen
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

- (void)tableView:(UITableView*)theTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
	// Remove the Recipe from our data model
	[[DataModel sharedInstance] removeRecipeAtIndex:indexPath.row];

	// Remove the row from the table with an animation
	[theTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
