
#import "SmoothiesViewController.h"
#import "Recipe.h"
#import "RecipeDetailsViewController.h"

@implementation SmoothiesViewController

@synthesize recipes;

- (id)initWithCoder:(NSCoder*)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		// Create the recipe list object
		recipes = [[NSMutableArray arrayWithCapacity:10] retain];

		// And add a few recipes to it
		Recipe* recipe = [[Recipe alloc] init];
		recipe.name = @"Banana Shake";
		recipe.instructions = @"1 frozen banana\n1 fresh banana\ndollop of coconut milk\nhalf a glass of water\noptional: pinch of vanilla";
		recipe.image = [UIImage imageNamed:@"Banana Shake.png"];
		[recipes addObject:recipe];
		[recipe release];

		recipe = [[Recipe alloc] init];
		recipe.name = @"Green Smoothie";
		recipe.instructions = @"2 bananas\nhalf a glass of orange juice\nhandful of fresh spinach";
		recipe.image = [UIImage imageNamed:@"Green Smoothie.png"];
		[recipes addObject:recipe];
		[recipe release];

		recipe = [[Recipe alloc] init];
		recipe.name = @"Raspberry-Blueberry";
		recipe.instructions = @"1 banana\n125 gr frozen raspberries\n125 gr frozen blueberries\n1 glass soy milk\nhalf a glass of water";
		recipe.image = [UIImage imageNamed:@"Raspberry-Blueberry.png"];
		[recipes addObject:recipe];
		[recipe release];
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
	[recipes release];
	[super dealloc];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView*)theTableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of recipes in our list
	return self.recipes.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	static NSString* CellIdentifier = @"RecipeCellIdentifier";

	// Obtain a table view cell for this row
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

	// Get the Recipe object from the list
	Recipe* recipe = [self.recipes objectAtIndex:indexPath.row];

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
	Recipe* recipe = [self.recipes objectAtIndex:indexPath.row];
	controller.recipe = recipe;

	// Show the Recipe Details screen
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

@end
