#!/usr/bin/env bash
# check_cybereason_requirements.sh
# Verify prerequisites for Cybereason on Ubuntu 22.04
# Usage: chmod +x check_cybereason_requirements.sh && ./check_cybereason_requirements.sh

set -euo pipefail

# --- utilities ---
info()  { printf "\e[34m[INFO]\e[0m %s\n" "$*"; }
ok()    { printf "\e[32m[ OK ]\e[0m %s\n" "$*"; }
warn()  { printf "\e[33m[WARN]\e[0m %s\n" "$*"; }
err()   { printf "\e[31m[FAIL]\e[0m %s\n" "$*"; }

FOUND_ALL_REQUIRED=true

# check a command exists
check_cmd() {
    local cmd="$1"
    if command -v "$cmd" >/dev/null 2>&1; then
        ok "Command available: $cmd -> $(command -v "$cmd")"
        return 0
    else
        err "Command missing: $cmd"
        return 1
    fi
}

# check library presence using ldconfig -p
check_lib() {
    local lib="$1"
    local matches
    matches=$(ldconfig -p 2>/dev/null | grep -F "$lib" || true)
    if [[ -n "$matches" ]]; then
        ok "Library found: $lib"
        printf "%s\n" "$matches" | sed -n '1,5p' | sed 's/^/    /'
        return 0
    else
        err "Library NOT found: $lib"
        return 1
    fi
}

# summary checker for required libs (collect missing)
check_required_lib() {
    local lib="$1"
    if ! check_lib "$lib"; then
        FOUND_ALL_REQUIRED=false
    fi
}

# --- Python check ---
info "Checking Python version (Python 2.6+ or any Python 3.x is accepted)"

PY_OK=false

if command -v python >/dev/null 2>&1; then
    ver_raw=$(python -V 2>&1)
    printf "    python -> %s\n" "$ver_raw"
    ver_major=$(echo "$ver_raw" | awk '{print $2}' | cut -d. -f1)
    ver_minor=$(echo "$ver_raw" | awk '{print $2}' | cut -d. -f2)
    if [[ "$ver_major" -ge 3 ]]; then
        ok "python (default) meets requirement: $ver_raw"
        PY_OK=true
    elif [[ "$ver_major" -eq 2 && "$ver_minor" -ge 6 ]]; then
        ok "python (default) meets requirement (2.6+): $ver_raw"
        PY_OK=true
    else
        warn "python (default) does NOT meet requirement: $ver_raw"
    fi
else
    info "python command not found"
fi

if command -v python3 >/dev/null 2>&1; then
    ver3_raw=$(python3 -V 2>&1)
    printf "    python3 -> %s\n" "$ver3_raw"
    ver3_major=$(echo "$ver3_raw" | awk '{print $2}' | cut -d. -f1)
    if [[ "$ver3_major" -ge 3 ]]; then
        ok "python3 meets requirement: $ver3_raw"
        PY_OK=true
    fi
else
    info "python3 not found"
fi

if ! $PY_OK; then
    err "No valid Python installation found (requires Python 2.6+ or Python 3.x)."
    FOUND_ALL_REQUIRED=false
fi

# --- iptables ---
info "Checking iptables"
if command -v iptables >/dev/null 2>&1; then
    ver_ipt=$(iptables --version 2>&1 | head -n1)
    ok "iptables present: $ver_ipt"
else
    err "iptables NOT found. Required for machine isolation."
    FOUND_ALL_REQUIRED=false
fi

# --- Libraries required ---
info "Checking required shared libraries (ldconfig -p)"

REQUIRED_LIBS=(
"libcurl.so.4"
"libnsl.so.1"
"librt.so.1"
"libpthread.so.0"
"libm.so.6"
"libgcc_s.so.1"
"libc.so.6"
"ld-linux-x86-64.so.2"
"libdl.so.2"
"libpopt.so.0"
"libelf.so.1"
"libattr.so.1"
"libz.so.1"
"libudev.so.1"
"libcap.so.2"
)

for lib in "${REQUIRED_LIBS[@]}"; do
    if ! check_lib "$lib"; then
        FOUND_ALL_REQUIRED=false
    fi
done

# librpm / librpmio (RPM-only)
info "Checking librpm / librpmio (required only on RPM-based distributions)"
if ldconfig -p 2>/dev/null | grep -E 'librpm(\.so|io)' >/dev/null 2>&1; then
    ok "librpm / librpmio found"
else
    warn "librpm / librpmio NOT found. Only required on RPM-based distributions (CentOS/RHEL)."
fi

# --- Optional packages ---
info "Checking gdb (OPTIONAL, recommended)"
if command -v gdb >/dev/null 2>&1; then
    ok "gdb present: $(command -v gdb)"
else
    warn "gdb NOT found (optional). Recommended for debugging."
fi

# policycoreutils requirement on Ubuntu 22.04:
info "Checking policycoreutils package (required for eBPF on some distros)"
if dpkg -s policycoreutils >/dev/null 2>&1; then
    ok "policycoreutils installed"
else
    warn "policycoreutils NOT installed. On Ubuntu 22.04 install it with: sudo apt update && sudo apt install policycoreutils"
    FOUND_ALL_REQUIRED=false
fi

# --- Final report ---
echo
info "Final summary:"
if $FOUND_ALL_REQUIRED; then
    ok "All *required* prerequisites seem to be present."
    exit 0
else
    err "Some prerequisites are missing or not confirmed."
    echo
    echo "Quick suggestions:"
    echo "  - For missing libraries: on Ubuntu try installing packages that provide them (e.g. libcurl4, libnsl2, libelf1, libpopt0, zlib1g, libcap2, libudev1, ...)."
    echo "  - For policycoreutils: sudo apt update && sudo apt install policycoreutils"
    echo "  - For Python3: sudo apt install python3"
    echo "  - If using an RPM-based system (CentOS/RHEL), install librpm/librpmio via yum/dnf."
    exit 2
fi
