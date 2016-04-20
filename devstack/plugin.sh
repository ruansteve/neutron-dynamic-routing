LIBDIR=$DEST/neutron_dynamic_routing/devstack/lib

source $LIBDIR/bgp

if [[ "$1" == "stack" ]]; then
    case "$2" in
        install)
            if is_service_enabled q-bgp; then
                configure_bgp
            fi
            ;;
        post-config)
            if is_service_enabled q-bgp && is_service_enabled q-bgp-agt; then
                configure_bgp_dragent
            fi
            ;;
        extra)
            if is_service_enabled q-bgp && is_service_enabled q-bgp-agt; then
                start_bgp_dragent
            fi
            ;;
    esac
elif [[ "$1" == "unstack" ]]; then
    if is_service_enabled q-bgp && is_service_enabled q-bgp-agt; then
        stop_bgp_dragent
    fi
fi
