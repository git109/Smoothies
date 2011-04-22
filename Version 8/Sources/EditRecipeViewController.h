
@class EditRecipeViewController;

/*
 * The delegate for EditRecipeViewController.
 */
@protocol EditRecipeDelegate <NSObject>
- (void)editRecipeDidSave:(EditRecipeViewController*)controller;
@optional
- (void)editRecipeDidCancel:(EditRecipeViewController*)controller;
@end

/*
 * The screen that lets you add a new recipe or edit an existing recipe.
 */
@interface EditRecipeViewController : UIViewController
	<
		UINavigationControllerDelegate,
		UIImagePickerControllerDelegate
	>
{
	UIImagePickerController* imagePicker;
}

@property (nonatomic, retain) IBOutlet UINavigationBar* navigationBar;
@property (nonatomic, retain) IBOutlet UITextField* nameTextField;
@property (nonatomic, retain) IBOutlet UIButton* choosePhotoButton;

// Our delegate object
@property (nonatomic, assign) id<EditRecipeDelegate> delegate;

// These properties will contain the edited values
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* instructions;
@property (nonatomic, retain) UIImage* image;

- (IBAction)cancel;
- (IBAction)save;
- (IBAction)choosePhoto;

@end
