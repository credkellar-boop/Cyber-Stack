rule CyberStack_Exploit_Heuristics {
    meta:
        description = "Detects structural anomalies indicative of buffer overflow attempts"
        author = "Cyber-Stack Defensive Logic"
        severity = "high"

    strings:
        // Detect common x86 NOP sleds
        $nop_sled_x86 = { 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 }
        
        // Detect common structural markers of encoded payloads
        $encoded_marker = "eval(base64_decode" ascii nocase

    condition:
        $nop_sled_x86 or $encoded_marker
}
