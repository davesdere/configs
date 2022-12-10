# Debug flag
set -o verbose

# Exit on error
set -o errexit

# Directory awareness
cwd=$(dirname -- $0)

# Validate byte size of a string
validate_under_4kb() {
test_string=$1
number_of_bytes=$(expr length ${test_string})
if [ "${number_of_bytes}" -gt "4096" ]; then
    echo "${test_string} of 4kb" >&2
    exit 1
else
    echo "${test_string} has ${number_of_bytes} bytes"
fi
}

# Remove new line char from a file and put it into a variable
one_line_variable=$(tr --delete '\n' < test.txt)

# Split string in variable in byte chunks (will generate files for output)
echo one_line_variable | split -b 4096 -d

# Replace string by another one stored in a variable (sed with variable)
sed -Ei -r "s|string_to_replace|${a_meaningful_variable}|g" a_target_file.txt