
#import "AdoredToothpastesViewController.h"
#import "ToothpastesTableTableViewController.h"

@interface AdoredToothpastesViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray *adoredToothpastes;
@property (weak, nonatomic) IBOutlet UITableView *adoredTableView;
@end

@implementation AdoredToothpastesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self load];
    if (self.adoredToothpastes == nil) {
        self.adoredToothpastes = [NSMutableArray new];
    }
}

-(IBAction)unWindFroomToothpastesViewController:(UIStoryboardSegue *)segue
{
    ToothpastesTableTableViewController *viewController = segue.sourceViewController;
    [self.adoredToothpastes addObject: [viewController adoredToothpaste]];
    [self.adoredTableView reloadData];
    [self save];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.adoredToothpastes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCellID"];
    cell.textLabel.text = [self.adoredToothpastes objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSURL*) documentsDirectory
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *files = [fileMgr URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    
    return files.firstObject;
}

-(void) load
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSURL *pList = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/2/lost.plist)"];
    self.adoredToothpastes = [NSMutableArray arrayWithContentsOfURL:pList];
}


-(void) save
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSURL *pList = [[self documentsDirectory] URLByAppendingPathComponent:@"pastes.plist"];
    [self.adoredToothpastes writeToURL:pList atomically:YES];
    [userDefaults setObject:[NSDate date] forKey:@"LastSaved"];
    [userDefaults synchronize];
}

@end
