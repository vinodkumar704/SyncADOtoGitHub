param(
     [Parameter()]
     [string]$GitHubDestinationPAT,
 
     [Parameter()]
     [string]$ADOSourcePAT
 )

# Write your PowerShell commands here.
Write-Host ' - - - - - - - - - - - - - - - - - - - - - - - - -'
Write-Host ' reflect Azure Devops repo changes to GitHub repo'
Write-Host ' - - - - - - - - - - - - - - - - - - - - - - - - - '
$AzureRepoName = "nestjs-project"
$ADOCloneURL = "dev.azure.com/BrainvireInfo/IT-Project/_git/nestjs-project"
$GitHubCloneURL = "github.com/vinodkumar704/nestjs-project.git"
$stageDir = pwd | Split-Path
Write-Host "stage Dir is : $stageDir"
$githubDir = $stageDir +"\"+"gitHub"
Write-Host "github Dir : $githubDir"
$destination = $githubDir+"\"+ $AzureRepoName+".git"
Write-Host "destination: $destination"
#Please make sure, you remove https from azure-repo-clone-url
$sourceURL = "https://$($ADOSourcePAT)"+"@"+"$($ADOCloneURL)"
write-host "source URL : $sourceURL"
#Please make sure, you remove https from github-repo-clone-url
write-host "tocken : $GitHubDestinationPAT"
write-host "clone URL : $GitHubCloneURL"
$destURL = "https://" + $($GitHubDestinationPAT) +"@"+"$($GitHubCloneURL)"
write-host "dest URL : $destURL"


# Set the source and destination repositories
$sourceRepo = $sourceURL
$destinationRepo = $destURL

# Set the name of the branch you want to mirror
$branchName = "main"

# Set the path to a temporary directory where the clone will be created
$tempDir = $githubDir

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

