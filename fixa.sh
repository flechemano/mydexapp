#!/bin/bash

# List of deprecated packages
deprecated_packages=(
    "natives@1.1.6"
    "source-map-url@0.4.1"
    "urix@0.1.0"
    "stable@0.1.8"
    "@babel/plugin-proposal-private-methods@7.18.6"
    "@babel/plugin-proposal-nullish-coalescing-operator@7.18.6"
    "@babel/plugin-proposal-numeric-separator@7.18.6"
    "@babel/plugin-proposal-class-properties@7.18.6"
    "resolve-url@0.2.1"
    "abab@2.0.6"
    "rollup-plugin-terser@7.0.2"
    "@babel/plugin-proposal-optional-chaining@7.21.0"
    "minimatch@2.0.10"
    "source-map-resolve@0.5.3"
    "graceful-fs@1.2.3"
    "domexception@2.0.1"
    "w3c-hr-time@1.0.2"
    "gulp-util@3.0.8"
    "sourcemap-codec@1.4.8"
    "minimatch@0.2.14"
    "workbox-cacheable-response@6.6.0"
    "workbox-google-analytics@6.6.0"
    "svgo@1.3.2"
)

# Iterate through each deprecated package
for package in "${deprecated_packages[@]}"; do
    echo "Checking update for ${package}..."
    current_version=$(npm show ${package%%@*} version 2>/dev/null)
    if [ -n "${current_version}" ]; then
        echo "Latest version available: ${current_version}"
        npm install "${package%%@*}"@"${current_version}" --save
    else
        echo "No update found for ${package}"
    fi
done

echo "All updates checked and applied."

