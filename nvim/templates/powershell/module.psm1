#Requires -Version 7
<#
.SYNOPSIS
  <Overview of script>
.PARAMETER <Parameter_Name>
    <Brief description of parameter input required. Repeat this attribute if required>
.INPUTS
  <Inputs if any, otherwise state None>
.OUTPUTS
  <Outputs if any, otherwise state None - example: Log file stored in C:\Windows\Temp\<name>.log>
.NOTES
  Version:        1.0
  Author:         {{_email_}}
  Creation Date:  {{_date_}}
  Purpose/Change: Initial script development
  
.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>
  Import-Module {{_file_name_}}.psm1
  {{_file_name_}}
#>

# Approved verbs can be found at the link below
# https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands
function Build-AzureCosts {
param(
    [DateTime] $start = [DateTime]::Today,
    [string[]] $missingTags, # Input takes CSV with ResourceID supplied tag replacements
    [string[]] $detailedEnrollment = "Detailed_Enrollment.csv"
    )

    #actual code for the function goes here see the end of the topic for the complete code sample
}

