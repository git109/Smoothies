
#import "SmoothiesViewController.h"
#import "DataModel.h"
#import "Recipe.h"
#import "RecipeDetailsViewController.h"

@implementation SmoothiesViewController

@synthesize dataModel;

- (id)initWithCoder:(NSCoder*)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		// Create the data model object
		dataModel = [[DataModel alloc] init];
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// Set the height of the table view rows
	self.tableView.rowHeight = 66;
}

- (void)dealloc
{
	[dataModel release];
	[super dealloc];
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

@end
