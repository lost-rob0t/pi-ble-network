{
  description = "simple way to setup a bluetooth tether";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    devShell.x86_64-linux =
      pkgs.mkShell {
        buildInputs = with pkgs; [
          ninja
          python311
          pipenv

          # deps
          python311Packages.dbus-python
          python311Packages.toml

        ];
        shellHook = ''
              export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath([pkgs.openssl.out])}:${pkgs.lib.makeLibraryPath([pkgs.libpcap])}
            '';
      };
  };
}
