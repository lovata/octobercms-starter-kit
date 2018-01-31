#!/usr/bin/env bash

# Standard user information message
function userMessage {
    case "$1" in
        success)
            echo -e "\n\e[32m✓ $2\e[0m\n"
            ;;
        warning)
            echo -e "\n\e[38;5;166m⚠ $2\e[0m\n"
            ;;
        error)
            echo -e "\n\e[31m❌ $2\e[0m\n"
            ;;
        info)
            echo -e "\n\e[34m🛈 $2\e[0m\n"
            ;;
    esac
}
