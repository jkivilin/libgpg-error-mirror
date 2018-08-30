
if echo "$0" | grep gpg-error-config 2>/dev/null >/dev/null; then
  myname="gpg-error-config"
else
  myname="gpgrt-config"
fi

usage()
{
    cat <<EOF
Usage: $myname [OPTIONS]
Options:
        [--mt]       (must be the first option)
	[--prefix]
	[--exec-prefix]
	[--version]
	[--libs]
	[--cflags]
EOF
    exit $1
}

if test $# -eq 0; then
    usage 1 1>&2
fi

if [ "$1" != "--mt" ]; then
    mt=no
else
    # In future, use --variable=mtcflags or --variable=mtlibs
    mt=yes
    shift
fi

read_config_file ${myname%-config} $PKG_CONFIG_PATH

opt_cflags=no
opt_libs=no
output=""

while test $# -gt 0; do
    case "$1" in
	-*=*)
	    optarg=`echo "$1" | sed 's/[-_a-zA-Z0-9]*=//'`
	    ;;
	*)
	    optarg=
	    ;;
    esac

    case $1 in
	--prefix)
	    # In future, use --variable=prefix instead.
	    output="$output $(get_var prefix)"
	    ;;
	--exec-prefix)
	    # In future, use --variable=exec_prefix instead.
	    output="$output $(get_var exec_prefix)"
	    ;;
	--version)
	    # In future, use --modversion instead.
	    echo "$(get_attr Version)"
	    exit 0
	    ;;
	--modversion)
	    echo "$(get_attr Version)"
	    exit 0
	    ;;
	--cflags)
	    opt_cflags=yes
	    ;;
	--libs)
	    opt_libs=yes
	    ;;
	--variable=*)
	    echo "$(get_var ${1#*=})"
	    exit 0
	    ;;
	--host)
	    # In future, use --variable=host instead.
	    echo "$(get_var host)"
	    exit 0
	    ;;
	*)
	    usage 1 1>&2
	    ;;
    esac
    shift
done

if [ opt_cflags = yes ]; then
    output="$output $(get_attr Cflags)"
    # Backward compatibility to old gpg-error-config
    if [ $mt = yes ]; then
	output="$output $(get_var mtcflags)"
    fi
fi
if [ opt_libs = yes ]; then
    output="$output $(get_attr Libs)"
    # Backward compatibility to old gpg-error-config
    if [ $mt = yes ]; then
	output="$output $(get_var mtlibs)"
    fi
fi

# cleanup_vars_attrs

echo $output
