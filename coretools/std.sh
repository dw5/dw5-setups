#!/bin/bash

# Define the input and output file paths
inputFilePath="input.txt"
outputFilePath="output.txt"

# Define the month name mappings
declare -A monthNamesEnglish=(
    ["January"]=01 ["February"]=02 ["March"]=03 ["April"]=04 ["May"]=05 ["June"]=06
    ["July"]=07 ["August"]=08 ["September"]=09 ["October"]=10 ["November"]=11 ["December"]=12
)

declare -A monthNamesLithuanian=(
    ["Sausio"]=01 ["Vasario"]=02 ["Kovo"]=03 ["Balandžio"]=04 ["Gegužės"]=05 ["Birželio"]=06
    ["Liepos"]=07 ["Rugpjūčio"]=08 ["Rugsėjo"]=09 ["Spalio"]=10 ["Lapkričio"]=11 ["Gruodžio"]=12
)

# Function to format date string
format_date_string() {
    local dateString="$1"

    # Remove comma and split the date string
    dateString="${dateString/,/}"
    IFS=' ' read -r -a parts <<< "$dateString"

    local day month year

    if [ ${#parts[@]} -eq 3 ]; then
        if [[ ! "${parts[0]}" =~ ^[0-9]+$ ]]; then
            month="${parts[0]}"
            day="${parts[1]}"
            year="${parts[2]}"
        elif [[ ! "${parts[1]}" =~ ^[0-9]+$ ]]; then
            day="${parts[0]}"
            month="${parts[1]}"
            year="${parts[2]}"
        elif [[ ! "${parts[2]}" =~ ^[0-9]+$ ]]; then
            year="${parts[0]}"
            month="${parts[1]}"
            day="${parts[2]}"
        fi
    elif [ ${#parts[@]} -eq 2 ]; then
        day="${parts[0]}"
        IFS=' ' read -r month year <<< "${parts[1]}"
    else
        echo "Invalid Date Format"
        return
    fi

    if [[ -n "${monthNamesEnglish[$month]}" ]]; then
        monthNumber="${monthNamesEnglish[$month]}"
    elif [[ -n "${monthNamesLithuanian[$month]}" ]]; then
        monthNumber="${monthNamesLithuanian[$month]}"
    else
        echo "Invalid Month Name"
        return
    fi

    printf "%04d-%02d-%02d\n" "$year" "$monthNumber" "$day"
}

# Read dates from the input file and process them
while IFS= read -r date; do
    formattedDate=$(format_date_string "$date")
    echo "$formattedDate"
done < "$inputFilePath" > "$outputFilePath"

echo "Formatted dates have been written to $outputFilePath"
