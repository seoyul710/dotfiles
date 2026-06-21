#!/usr/bin/env bash

set -euo pipefail

usage() {
    cat <<'EOF'
Usage:
  ./switch-profile.sh list
  ./switch-profile.sh apply <profile-name> [--backup] [--logo-type <type>]

Profiles are loaded from ../profiles/<profile-name>.
Each profile may contain:
  starship.toml
  fastfetch/config.jsonc
  fastfetch/assets/*
EOF
}

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
profiles_dir="$repo_root/profiles"
backup_enabled=0
logo_type=""

list_profiles() {
    if [[ ! -d "$profiles_dir" ]]; then
        echo "No profiles directory found: $profiles_dir" >&2
        exit 1
    fi

    find "$profiles_dir" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort
}

backup_path() {
    local target="$1"

    if [[ ! -e "$target" ]]; then
        return
    fi

    local timestamp
    timestamp="$(date +%Y%m%d-%H%M%S)"
    cp -R "$target" "$target.backup.$timestamp"
}

detect_logo_type() {
    if [[ -n "$logo_type" ]]; then
        echo "$logo_type"
        return
    fi

    case "$(uname -s)" in
        Darwin)
            echo "kitty-direct"
            ;;
        *)
            echo "kitty"
            ;;
    esac
}

patch_fastfetch_logo_type() {
    local config_path="$1"
    local detected_logo_type

    detected_logo_type="$(detect_logo_type)"

    if ! grep -q '"type"[[:space:]]*:[[:space:]]*"kitty' "$config_path"; then
        return
    fi

    perl -0pi -e "s/\"type\"\\s*:\\s*\"kitty(?:-direct)?\"/\"type\": \"$detected_logo_type\"/" "$config_path"
}

apply_profile() {
    local profile_name="$1"
    local profile_dir="$profiles_dir/$profile_name"

    if [[ ! -d "$profile_dir" ]]; then
        echo "Profile not found: $profile_name" >&2
        echo "Available profiles:" >&2
        list_profiles >&2
        exit 1
    fi

    if [[ ! -f "$profile_dir/starship.toml" ]]; then
        echo "Missing profile file: $profile_dir/starship.toml" >&2
        exit 1
    fi

    if [[ ! -f "$profile_dir/fastfetch/config.jsonc" ]]; then
        echo "Missing profile file: $profile_dir/fastfetch/config.jsonc" >&2
        exit 1
    fi

    mkdir -p "$HOME/.config"

    if [[ "$backup_enabled" -eq 1 ]]; then
        backup_path "$HOME/.config/starship.toml"
        backup_path "$HOME/.config/fastfetch"
    fi

    cp "$profile_dir/starship.toml" "$HOME/.config/starship.toml"
    rm -rf "$HOME/.config/fastfetch"
    cp -R "$profile_dir/fastfetch" "$HOME/.config/fastfetch"
    patch_fastfetch_logo_type "$HOME/.config/fastfetch/config.jsonc"

    echo "$profile_name" > "$HOME/.config/dotfiles-profile"
    echo "Applied profile: $profile_name"
    echo "Fastfetch logo type: $(detect_logo_type)"
}

if [[ $# -lt 1 ]]; then
    usage
    exit 1
fi

command="$1"
shift

case "$command" in
    list)
        list_profiles
        ;;
    apply)
        if [[ $# -lt 1 ]]; then
            usage
            exit 1
        fi

        profile_name="$1"
        shift

        while [[ $# -gt 0 ]]; do
            case "$1" in
                --backup)
                    backup_enabled=1
                    ;;
                --logo-type)
                    if [[ $# -lt 2 ]]; then
                        echo "Missing value for --logo-type" >&2
                        usage
                        exit 1
                    fi
                    logo_type="$2"
                    shift
                    ;;
                *)
                    echo "Unknown option: $1" >&2
                    usage
                    exit 1
                    ;;
            esac
            shift
        done

        apply_profile "$profile_name"
        ;;
    *)
        echo "Unknown command: $command" >&2
        usage
        exit 1
        ;;
esac
