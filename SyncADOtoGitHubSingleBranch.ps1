# Set the source and destination repositories
$sourceRepo = "https://dev.azure.com/yourorg/yourproject/_git/yourrepo"
$destinationRepo = "https://github.com/yourorg/yourrepo.git"

# Set the name of the branch you want to mirror
$branchName = "main"

# Set the path to a temporary directory where the clone will be created
$tempDir = "C:\temp"

# Clone the source repository
Write-Host "Cloning $sourceRepo to $tempDir"
git clone $sourceRepo $tempDir

# Change to the cloned repository directory
cd $tempDir

# Fetch the latest changes from the source repository
Write-Host "Fetching changes from $sourceRepo"
git fetch origin

# Checkout the branch to mirror
Write-Host "Checking out $branchName"
git checkout $branchName

# Push the branch to the destination repository
Write-Host "Pushing changes to $destinationRepo"
git push $destinationRepo $branchName

# Clean up the temporary directory
Write-Host "Cleaning up"
Remove-Item -Recurse -Force $tempDir
