Get-ChildItem -File | ForEach-Object {

if ($\_.Name -match '(\\d+)\\.png$') {

$newName = "$($matches\[1\]).png"

Rename-Item -Path $\_.FullName -NewName $newName

}

}
