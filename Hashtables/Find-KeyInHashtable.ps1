#####################################################################################################
# Find-KeyInHashtable - https://github.com/wrcsubers/PowerShell_ScriptsAndModules
#####################################################################################################

# Purpose: This function will recursively search a hashtable (single or multi-depth) for a specific key.
#
# Parameters:
# 	- The mandatory parameter $Hashtable accepts a hashtable.  This is the hashtable to search.
#   - The mandatory parameter $KeyToFind accepts a string.  This is the key you'd like to find in the
#     hashtable.
#
# Usage:
#	$DemoHashtable = [ordered]@{
#		'Key1' = 'Value1'
#		'Key2' = [ordered]@{
#			'Subkey1' = 'Subvalue1'
#			'Subkey2' = [ordered]@{
#				'SuperSubkey1' = 'SuperSubvalue1'
#			}
#      	}
#		'Key3' = 'Value3'
#	}
#	
#	Input - Find-KeyInHashtable -Hashtable $DemoHashtable -KeyToFind 'SuperSubkey1'
# 	Output - SuperSubvalue1
#	Input - Find-KeyInHashtable -Hashtable $DemoHashtable -KeyToFind 'Key2'
#	Output - [Subkey1, Subkey2]


#####################################################################################################
# Recursively Search Hashtable for specific Key
#####################################################################################################

function Find-KeyInHashtable
{
    [CmdletBinding()]
    [OutputType('String')]
    Param
    (
        [Parameter(Mandatory)]
        $Hashtable,
        [Parameter(Mandatory)]
        [string]$KeyToFind
    )

    Process
    {
        foreach ($Key in $Hashtable.Keys.GetEnumerator()){
            if ($Key -eq $KeyToFind){
                if (($Hashtable.$Key -is [System.Collections.IEnumerable]) -and ($Hashtable.$Key -isnot [string]) -and ($Hashtable.$Key -isnot [array])) {
                    return ($Hashtable.$Key.GetEnumerator()).Name
                } else {
                    return $Hashtable.$Key
                }
            } elseif (($Hashtable.$Key -is [System.Collections.IEnumerable]) -and ($Hashtable.$Key -isnot [string]) -and ($Hashtable.$Key -isnot [array])) {
                Find-KeyInHashtable -Hashtable $Hashtable.$Key -KeyToFind $KeyToFind
            }
        }
    }
}