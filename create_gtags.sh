#!/bin/bash

# https://unix.stackexchange.com/questions/15308/how-to-use-find-command-to-search-for-multiple-extensions
find . -type f \( -name \*.h.template -o -name \*.cpp -o -name \*.hpp -o -name \*.h -o -name \*.c -o -name \*.cc -o -name \*.hh \) | grep -v "/ext/" | grep -v "/target/" > /tmp/gtags_file_list


# https://www.gnu.org/software/global/globaldoc_toc.html
gtags -f /tmp/gtags_file_list
