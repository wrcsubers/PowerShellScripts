#####################################################################################################
# Make-HTMLList - https://github.com/wrcsubers/PowerShell_ScriptsAndModules
#####################################################################################################

# Purpose: This function accepts an array of strings to create an ordered or unordered HTML List
#
# Parameters:
# 	- The mandatory parameter $ListItems accepts an array of strings.  Each string in the array becomes
#	  a single list item
#   - The optional parameter $ListTitle accepts a string.  This string becomes an h2 tag above the list.
#   - The optional parameter $MakeUnordered is a switch.  If used, the list will an unordered (bulleted)
#     list instead of a ordered (numbered) list.
#
# Usage:
#	Input - Make-HTMLList -ListTitle 'A title for your list' -ListItems @('Item 1', 'Item 2', 'Item 3') -MakeUnordered
# 	Output - <h2>A title for your list</h2>
#            <ul>
#			 	 <li>Item 1</li>
#				 <li>Item 2</li>
#				 <li>Item 3</li>
#			 </ul>
#			 <hr>


function Make-HTMLList
{
    [CmdletBinding()]
    [OutputType('String')]
    Param
    (
        [Parameter(Mandatory)]
        [String[]]$ListItems,
        [String]$ListTitle,
        [Switch]$MakeUnordered
    )

    Process
    {
        # Determine which tags to use
        if ($MakeUnordered -eq $true){
            $ListTags = @('<ul>','</ul>')
        } else {
            $ListTags = @('<ol>','</ol>')
        }

        # Title List with an h2 tag if present
        if (($ListTitle -ne $null) -and ($ListTitle -ne '')){
            $HTMLList += "`n<h2>$ListTitle</h2>"
        }
        
        # Tag start of list
        $HTMLList += "`n$($ListTags[0])"
        
        # Tag each list item
        for ($i = 0; $i -lt $ListItems.Count; $i++){ 
            $HTMLList += "`n`t<li>$($ListItems[$i])</li>"
        }
        
        # Tag end of list
        $HTMLList += "`n$($ListTags[1])`n<hr>"
        
        return $HTMLList
    }
}