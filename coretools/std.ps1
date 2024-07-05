# Define the input and output file paths
$inputFilePath = "input.txt"
$outputFilePath = "output.txt"

# Define the month name mappings
$monthNamesEnglish = @{
    January = 1; February = 2; March = 3; April = 4; May = 5; June = 6;
    July = 7; August = 8; September = 9; October = 10; November = 11; December = 12
}

$monthNamesLithuanian = @{
    Sausio = 1; Vasario = 2; Kovo = 3; Balandžio = 4; Gegužės = 5; Birželio = 6;
    Liepos = 7; Rugpjūčio = 8; Rugsėjo = 9; Spalio = 10; Lapkričio = 11; Gruodžio = 12
}

# Function to format date string
function Format-DateString {
    param (
        [string]$dateString
    )

    $dateString = $dateString -replace ',', ''
    $parts = $dateString -split ' '

    if ($parts.Count -eq 3) {
        if (-not ($parts[0] -match '^\d+$')) {
            $month = $parts[0]
            $day = $parts[1]
            $year = $parts[2]
        } elseif (-not ($parts[1] -match '^\d+$')) {
            $day = $parts[0]
            $month = $parts[1]
            $year = $parts[2]
        } elseif (-not ($parts[2] -match '^\d+$')) {
            $year = $parts[0]
            $month = $parts[1]
            $day = $parts[2]
        }
    } elseif ($parts.Count -eq 2) {
        $day = $parts[0]
        $month, $year = $parts[1] -split ' '
    } else {
        return "Invalid Date Format"
    }

    if ($monthNamesEnglish.ContainsKey($month)) {
        $monthNumber = $monthNamesEnglish[$month]
    } elseif ($monthNamesLithuanian.ContainsKey($month)) {
        $monthNumber = $monthNamesLithuanian[$month]
    } else {
        return "Invalid Month Name"
    }

    $monthNumber = "{0:D2}" -f $monthNumber
    $day = "{0:D2}" -f [int]$day

    return "$year-$monthNumber-$day"
}

# Read dates from the input file
$dates = Get-Content -Path $inputFilePath

# Process and format each date
$formattedDates = foreach ($date in $dates) {
    Format-DateString -dateString $date
}

# Write the formatted dates to the output file
$formattedDates | Set-Content -Path $outputFilePath

Write-Output "Formatted dates have been written to $outputFilePath"
