#concept

# Set the output directory to the current working directory
out_dir=$(pwd)

# Print a message indicating the current working directory
echo "Folders in: $(pwd)"

# Find all subdirectories in the current working directory
subdirs=$(find . -type d)

# Iterate over the subdirectories in parallel
# The "-I {}" option specifies the placeholder for the subdirectory name
# The "-j+0" option specifies that parallel should use as many cores as are available
parallel -I {} -j+0 bash -c '
  # Print the name of the subdirectory
  echo "Processing subdirectory: {}"
  
  # Find all files in the subdirectory
  files=$(find {} -type f)
  
  # Iterate over the files and move them to the output directory
  for file in $files; do
    mv "$file" "$out_dir"
  done
  
  # Check if the subdirectory is empty
  if [ -z "$(ls -A {})" ]; then
    # If the subdirectory is empty, move it to the "deletable" subdirectory
    echo "OKDEL: No files found in {}"
    mkdir -p "$out_dir/deletable"
    mv {} "$out_dir/deletable"
  else
    # If the subdirectory is not empty, move it to the "foldyattention" subdirectory
    echo "|||| WARNING: {} has files/folders"
    mkdir -p "$out_dir/foldyattention"
    mv {} "$out_dir/foldyattention"
  fi
' $subdirs
