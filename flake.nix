{
  description = "music library handling for tunebook";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url  = "github:numtide/flake-utils";

    just.url = "github:casey/just/1.50.0";
    versionctl.url = "github:nanoteck137/versionctl/0.3.0";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [];
        pkgs = import nixpkgs {
          inherit system overlays;
        };

        version = pkgs.lib.strings.fileContents "${self}/version";
        fullVersion = ''${version}-${self.dirtyShortRev or self.shortRev or "dirty"}'';

        app = pkgs.buildGoModule {
          pname = "tunebook-bridge";
          version = fullVersion;
          src = ./.;
          subPackages = ["cmd/tunebook-bridge"];

          ldflags = [
            "-X github.com/nanoteck137/tunebook-bridge.Version=${version}"
            "-X github.com/nanoteck137/tunebook-bridge.Commit=${self.dirtyRev or self.rev or "no-commit"}"
          ];

          vendorHash = null;
        };
      in
      {
        packages = {
          default = app;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            go
            gopls

            inputs.just.packages.${system}.default
            inputs.versionctl.packages.${system}.default
          ];
        };
      }
    );
}
