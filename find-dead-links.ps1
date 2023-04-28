
##
## Find dead links from a web page
## Change $rootURI and ----
##


$rootURI = ''

$parent = Invoke-WebRequest –Uri $rootURI -UseBasicParsing

$links = $parent.Links | Select href

$uniqueLinkSet = @()

$deadLinks = @()

for ($counter = 0; $counter -lt $links.Count; $counter++)
{
    
    $currentLink = $links[$counter].href

    if($currentLink){

    
        if( ($uniqueLinkSet -notcontains $currentLink) -and ($currentLink -ne '#') -and ($currentLink -ne '/') -and ($currentLink -ne '')){
        

            if($currentLink.Substring(0,1) -eq '/'){

                $currentLink = 'https://www.epson.com.au' + $currentLink

            }

            if(($currentLink.Substring(0,1) -ne '#' ) -and ($uniqueLinkSet -notcontains $currentLink)){
                $uniqueLinkSet += $currentLink

                try{
            
                    $Response = Invoke-WebRequest -Uri $currentLink -useBasicParsing
                    #Write-output "$counter : Status Code -- $($Response.StatusCode)"
            
                } catch{
                    Write-host $currentLink + $_.Exception.Response.StatusCode.Value__ -ForegroundColor Red
                    #$deadLinks = $currentLink + $_.Exception.Response.StatusCode.Value__
                
                }
            
            }

        
        }
    }

}

#$uniqueLinkSet  | Out-File -FilePath C:\Users\----\Documents\mytest.csv
#$deadLinks  | Out-File -FilePath C:\Users\----\Documents\dead-links.csv
