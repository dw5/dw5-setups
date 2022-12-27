# Set the output directory to the current working directory
out_dir=$(pwd)

# Print a message indicating the current working directory
echo "Folders in: $(pwd)"

# Find all subdirectories in the current working directory
subdirs=$(find . -type d)

# Iterate over the subdirectories
for subdir in $subdirs; do
  # Print the name of the subdirectory
  echo "Processing subdirectory: $subdir"
  
  # Find all files in the subdirectory
  files=$(find "$subdir" -type f)
  
  # Iterate over the files and move them to the output directory
  for file in $files; do
    mv "$file" "$out_dir"
  done
  
  # Check if the subdirectory is empty
  if [ -z "$(ls -A $subdir)" ]; then
    # If the subdirectory is empty, move it to the "deletable" subdirectory
    echo "OKDEL: No files found in $subdir"
    mkdir -p "$out_dir/deletable"
    mv "$subdir" "$out_dir/deletable"
  else
    # If the subdirectory is not empty, move it to the "foldyattention" subdirectory
    echo "|||| WARNING: $subdir has files/folders"
    mkdir -p "$out_dir/foldyattention"
    mv "$subdir" "$out_dir/foldyattention"
  fi
done
