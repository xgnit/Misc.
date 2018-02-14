$ cat substring_function.sh                                
#!/bin/sh

is_substring(){
    case "$2" in
        *$1*) return 0;;
        *) return 1;;
    esac
}

main(){
   if is_substring "ab" "abcdefg"
   then
       echo "ab is substring"
   fi
}
