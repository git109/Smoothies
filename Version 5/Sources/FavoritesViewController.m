
#import "FavoritesViewController.h"

@implementation FavoritesViewController

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
	NSArray* favorites = [[NSUserDefaults standardUserDefaults] objectForKey:@"Favorites"];
	return favorites.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	static NSString* CellIdentifier = @"RecipeCellIdentifier";

	// Obtain a table view cell for this row
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

	// Get the name of the favorite from the list
	NSArray* favorites = [[NSUserDefaults standardUserDefaults] objectForKey:@"Favorites"];
	NSString* recipeName = [favorites objectAtIndex:indexPath.row];

	// Put the recipe name into the cell
	cell.textLabel.text = recipeName;
	return cell;
}

@end
