LIBDIR=$NEUTRON_DYNAMIC_ROUTING_DIR/devstack/lib

source $LIBDIR/bgp

if [[ "$1" == "stack" ]]; then
    case "$2" in
        install)
            echo_summary "Installing neutron-dynamic-routing"
            if is_service_enabled q-bgp; then
                configure_bgp
            fi
            ;;
        post-config)
            echo_summary "Configuring neutron-dynamic-routing"
            if is_service_enabled q-bgp && is_service_enabled q-bgp-agt; then
                generate_config_files
                configure_bgp_dragent
            fi
            ;;
        extra)
            echo_summary "Lauching neutron-dynamic-routing dr-agent"
            if is_service_enabled q-bgp && is_service_enabled q-bgp-agt; then
                start_bgp_dragent
            fi
            ;;
    esac
elif [[ "$1" == "unstack" ]]; then
    echo_summary "Uninstalling neutron-dynamic-routing"
    if is_service_enabled q-bgp && is_service_enabled q-bgp-agt; then
        stop_bgp_dragent
    fi
fi
