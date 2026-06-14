rule CyberStack_Telemetry_Marker {
    meta:
        description = "Identifies baseline binary indicators for workspace verification"
        author = "Cyber-Stack"
        version = "1.0"
    
    strings:
        $engine_string = "cyber_stack_orchestrator" ascii wide
        $kernel_marker = "xdp_pass_prog" ascii
        
    condition:
        any of them
}
