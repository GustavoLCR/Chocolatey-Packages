function Get-AppVeyorArtifacts
{
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param(
        #The name of the account you wish to download artifacts from
        [parameter(Mandatory = $true)]
        [string]$Account,
        #The name of the project you wish to download artifacts from
        [parameter(Mandatory = $true)]
        [string]$Project,
        #Where to save the downloaded artifacts. Defaults to current directory.
        [alias("DownloadDirectory")][string]$Path = '.',
        [string]$Token,
        #Filter to a specific branch or project directory. You can specify Branch as either branch name ("master") or build version ("0.1.29")
        [string]$Branch,
        #If you have multiple build jobs, specify which job you wish to retrieve the artifacts from
        [string]$JobName,
        #Download all files into a single directory, do not preserve any hierarchy that might exist in the artifacts
        [switch]$Flat,
        [string]$Proxy,
        [switch]$ProxyUseDefaultCredentials,
        #URL of Appveyor API. You normally shouldn't need to change this.
        $apiUrl = 'https://ci.appveyor.com/api'
    )

    $headers = @{
        'Content-type' = 'application/json'
    }

    if ($Token) {$headers.'Authorization' = "Bearer $token"}

    # Prepare proxy args to splat to Invoke-RestMethod
    $proxyArgs = @{}
    if (-not [string]::IsNullOrEmpty($proxy)) {
        $proxyArgs.Add('Proxy', $proxy)
    }
    if ($proxyUseDefaultCredentials.IsPresent) {
        $proxyArgs.Add('ProxyUseDefaultCredentials', $proxyUseDefaultCredentials)
    }

    $errorActionPreference = 'Stop'
    
    $projectURI = "$apiUrl/projects/$account/$project/history`?recordsNumber=50"
    if ($Branch) {$projectURI = $projectURI + "&branch=$Branch"}

    $projectObject = Invoke-RestMethod -Method Get -Uri $projectURI `
                                       -Headers $headers @proxyArgs

    if (-not $projectObject.builds) {
        throw "No builds found for this project or the project and/or account name was incorrectly specified"
    }

    $buildId = ($projectObject.builds | Where-Object {($_.status -eq "success") -and -not $_.pullRequestId} | Select-Object -First 1).buildId

    if (-not $buildId) {
        throw "No successful build found for this project in the lastest 50 builds"
    }

    $buildURI = "$apiUrl/projects/$account/$project/builds/$buildId"
    
    $build = Invoke-RestMethod -Method Get -Uri $buildURI `
                               -Headers $headers @proxyArgs

    if (($build.build.jobs.count -gt 1) -and -not $jobName) {
        throw "Multiple Jobs found for the latest build. Please specify the -JobName paramter to select which job you want the artifacts for"
    }
    
    Write-Host "Found build '$buildId': '$($build.build.message)' commitId: '$($build.build.commitId)'"
    
    if ($JobName) {
        $job = $build.build.jobs | Where-Object name -eq "$JobName" | Select-Object -First 1
        if (-not $job) {throw "Unable to find a job named $JobName within the latest successful build. Did you spell it correctly?"}
        $jobid = $job.jobid
    } else {
        $jobid = $build.build.jobs[0].jobid
    }

    $artifacts = Invoke-RestMethod -Method Get -Uri "$apiUrl/buildjobs/$jobId/artifacts" `
                                   -Headers $headers @proxyArgs
    $artifacts `
    | Where-Object { $psCmdlet.ShouldProcess($_.fileName) } `
    | ForEach-Object {

        $type = $_.type

        $localArtifactPath = $_.fileName -split '/' | ForEach-Object { [Uri]::UnescapeDataString($_) }
        if ($flat.IsPresent) {
            $localArtifactPath = ($localArtifactPath | Select-Object -Last 1)
        } else {
            $localArtifactPath = $localArtifactPath -join [IO.Path]::DirectorySeparatorChar
        }
        $localArtifactPath = Join-Path $path $localArtifactPath

        $artifactUrl = "$apiUrl/buildjobs/$jobId/artifacts/$($_.fileName)"
        Write-Verbose "Downloading $artifactUrl to $localArtifactPath"

        Invoke-RestMethod -Method Get -Uri $artifactUrl -OutFile $localArtifactPath -Headers $headers @proxyArgs

        New-Object PSObject -Property @{
            'Source'   = $artifactUrl
            'FileName' = $_.fileName
            'Type'     = $type
            'Target'   = $localArtifactPath
            'Commit'   = $build.build.commitId
        }
    }
}
