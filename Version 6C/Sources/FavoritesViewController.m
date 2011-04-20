
#import "FavoritesViewController.h"
#import "DataModel.h"
#import "Recipe.h"

@implementation FavoritesViewController

@synthesize dataModel;

- (void)viewDidLoad
{
	[super viewDidLoad];

	// Set the height of the table view rows
	self.tableView.rowHeight = 66;
}

- (void)viewWillAppear:(BOOL)animated
{
	// Refresh the contents of the table whenever this screen becomes visible
	[super viewWillAppear:animated];
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView*)theTableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of favorites
	return [self.dataModel favoritesCount];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	static NSString* CellIdentifier = @"RecipeCellIdentifier";

	// Obtain a table view cell for this row
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

	// Get the favorite Recipe from the list
	Recipe* recipe = [self.dataModel favoriteAtIndex:indexPath.row]; 

	// Put the Recipe data into the cell
	cell.textLabel.text = recipe.name;
	cell.imageView.image = recipe.image;

	return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
