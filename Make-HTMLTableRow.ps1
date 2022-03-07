#####################################################################################################
# Make-HTMLTableRow - https://github.com/wrcsubers/PowerShell_ScriptsAndModules
#####################################################################################################

# Purpose: This function accepts an array of strings and creates a single row of data for an HTML Table
#
# Parameters:
# 	- The mandatory parameter $RowData accepts an array of strings.  Each string in the array becomes
#	  a single cell value
#   - The optional parameter $FirstColumnIsHeader is a switch.  If used, the first column in each row
#	  will be a header.  This allows the creation of atypical tables.
#   - The optional parameter $IsHeaderRow is a switch.  If used, this row will be a header row
#
# Usage:
#	Input - Make-HTMLTableRow -RowData @('Item 1', 'Item 2', 'Item 3')
# 	Output - <tr><td>Item 1</td><td>Item 2</td><td>Item 3</td></tr>


function Make-HTMLTableRow
{
    [CmdletBinding()]
    [OutputType('String')]
    Param
    (
        [Parameter(Mandatory)]
        [String[]]$RowData,
        [Switch]$FirstColumnIsHeader,
        [Switch]$IsHeaderRow
    )

    Process
    {
        # Tag start of row
        $TableRowHTML = "`n`t<tr>"
        
        # Iterate through array and tag each element
        for ($i = 0; $i -lt $RowData.Count; $i++){ 
            
            # If the first column is a header, give the first element of the row a header tag
            if (($FirstColumnIsHeader -eq $true) -and ($i -eq 0)){
                $TableRowHTML += "<th>$($RowData[$i])</th>"
            } else {
                
                # If this is a header row, give each element of the row a header tag, otherwise give it a data tag
                if ($IsHeaderRow -eq $true){
                    $TableRowHTML += "<th>$($RowData[$i])</th>"
                } else {
                    $TableRowHTML += "<td>$($RowData[$i])</td>"
                }
            }
        }
        
        # Tag end of row
        $TableRowHTML += "</tr>"
        
        return $TableRowHTML
    }
}