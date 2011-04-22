
#import "EditRecipeViewController.h"

@implementation EditRecipeViewController

@synthesize navigationBar, nameTextField, choosePhotoButton, delegate,
			name, instructions, image;

- (void)viewDidLoad
{
	[super viewDidLoad];

	// If a name is set, then we must be editing an existing recipe
	if (self.name != nil)
	{
		self.navigationBar.topItem.title = @"Edit Recipe";
		self.nameTextField.text = self.name;
	}

	// If the recipe has an image, set it on the button
	if (self.image != nil)
		[self.choosePhotoButton setImage:self.image forState:UIControlStateNormal];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	self.navigationBar = nil;
	self.nameTextField = nil;
	self.choosePhotoButton = nil;
}

- (void)dealloc
{
	[navigationBar release];
	[nameTextField release];
	[choosePhotoButton release];
	[name release];
	[instructions release];
	[image release];
	[super dealloc];
}

- (IBAction)cancel
{
	// Notify the delegate if it implements the optional method
	if ([self.delegate respondsToSelector:@selector(editRecipeDidCancel:)])
		[self.delegate editRecipeDidCancel:self];

	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (IBAction)save
{
	// Make sure the user has entered at least a recipe name
	if (self.nameTextField.text.length == 0)
	{
		UIAlertView* alertView = [[UIAlertView alloc]
			initWithTitle:@"Whoops..."
			message:@"Please enter a recipe name"
			delegate:nil
			cancelButtonTitle:@"OK"
			otherButtonTitles:nil];
		
		[alertView show];
		[alertView release];
		return;
	}

	self.name = self.nameTextField.text;

	// Notify the delegate and close the screen
	[self.delegate editRecipeDidSave:self];
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (IBAction)choosePhoto
{
	// Show the image picker with the photo library
	imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePicker.delegate = self;
	imagePicker.allowsEditing = YES;
	[self presentModalViewController:imagePicker animated:YES];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
	// We get here when the user has successfully picked an image.
	// Put the image in our property and set it on the button.
	self.image = [info objectForKey:UIImagePickerControllerEditedImage];
	[self.choosePhotoButton setImage:self.image forState:UIControlStateNormal];

	[self dismissModalViewControllerAnimated:YES];
	[imagePicker release];
	imagePicker = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
	[self dismissModalViewControllerAnimated:YES];
	[imagePicker release];
	imagePicker = nil;
}

@end
