DTC=dtc

function strip_path_and_extension {
    BASE=$(basename $1)
    BASE=${BASE%.*}

    echo "$BASE"
}

function is_dtb {
    BASE=$(basename $1)
    EXT=${BASE##*.}

    if [ "$EXT" = "dtb" ] ; then
	echo "true"
    else
	echo "false"
    fi
}

function source_and_sort {
    DT="$1"
    if [ -d "$DT" ]; then
	IFORMAT=fs
    elif [ -f "$DT" ]; then
	case "$DT" in
	    *.dts)
		IFORMAT=dts
		;;
	    *.dtb)
		IFORMAT=dtb
		;;
	esac
    fi

    if [ -z "$IFORMAT" ]; then
	echo "Unrecognized format for $DT" >&2
	return 2
    fi

    OUT=/tmp/$2/$(strip_path_and_extension $DT).dts
    $DTC $3 -I $IFORMAT -O dts -o "$OUT" "$DT"

    echo "$OUT"
}

function dtdiff {

    if [ "$1" = "-s" ]; then
	echo "sorting enabled"
	DTCARGS="-s"
	shift
    else
	DTCARGS=""
    fi

    mkdir -p /tmp/1 /tmp/2

    if [ -n "$1" ]; then
	FIRST=$(source_and_sort $1 "1" $DTCARGS)
    fi

    if [ -n "$2" ]; then
    	SECOND=$(source_and_sort $2 "2" $DTCARGS)
    fi

    if [ $# -gt 1 ]; then
    	meld $FIRST $SECOND
    elif [ $# -eq 1 ]; then
    	emacs -nw $FIRST
    fi

    if [ $? -eq 0 ] && [ -z $DTCARGS ]; then
	if [ $(is_dtb $1) = "true" ]; then
	    if [ $# -gt 0 ]; then
		echo "compiled $FIRST ----> $1"
		$DTC -I dts -O dtb -o $1 $FIRST
	    fi
	    if [ $# -gt 1 ]; then
		echo "compiled $SECOND ----> $2"
		$DTC -I dts -O dtb -o $2 $SECOND
	    fi
	fi
    else
	echo "Your editing tools did not exit gracefully or you had sorting enabled."
	echo "dtb files were not updated!"
    fi
}
