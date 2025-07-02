# Get user home directory
$homePath = $env:USERPROFILE
# Define the path to the auth.toml file
$authTomlPath = Join-Path $env:APPDATA "pypoetry\auth.toml"

Write-Host "Trying to find existing credentials..."

# Check if the auth.toml file exists and extract the token
if (Test-Path $authTomlPath) {
    $authContent = Get-Content -Path $authTomlPath -Raw
    if ($authContent -match '\[http-basic\.packagr\]\s+username\s*=\s*"__token__"\s+password\s*=\s*"([^"]+)"') {
        $tokenText = $matches[1]
        Write-Host "Token extracted from auth.toml"
    } else {
        Write-Host "Token not found in Poetry's auth.toml. Please enter it manually."
        $token = Read-Host "Enter your repoforge token (ask EBG/SLF for a token)" -AsSecureString
        $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($token)
        $tokenText = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    }
} else {
    Write-Host "Existing authentication file not found. Please enter your token manually."
    $token = Read-Host "Enter your repoforge token (ask EBG/SLF for a token)" -AsSecureString
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($token)
    $tokenText = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
}

# Create netrc entry
$netrcEntry = @"
machine api.repoforge.io
login __token__
password $tokenText
"@

# Append to _netrc file
$netrcPath = Join-Path $homePath "_netrc"
# Check for existing entry to _netrc file, add newline if it exists
if (Test-Path $netrcPath) { Add-Content -Path $netrcPath -Value "`n" }
Add-Content -Path $netrcPath -Value $netrcEntry

# Set file as read-only
Set-ItemProperty -Path $netrcPath -Name IsReadOnly -Value $true

Write-Host "Credentials saved to $netrcPath"
