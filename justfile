default:
    just -l

gen:
    nix run github:nanoteck137/pyrin -- gen go tunebook-pyrin.json

test-build:
    nix build --no-link .#
