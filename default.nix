# reference: https://dev.to/misterio/how-to-package-a-rust-app-using-nix-3lh3
{ pkgs ? import <nixpkgs> {} }:
let  
    manifest = pkgs.lib.importTOML ./Cargo.toml;
in 
pkgs.rustPlatform.buildRustPackage {
  pname = "uzbekl10nbot";
  version = "1.0.0";
  cargoLock.lockFile = ./Cargo.lock;
  src = pkgs.lib.cleanSource ./.;


  # Tests require network access. Skipping.
  doCheck = false;

  meta = {
    description = "Fast line-oriented regex search tool, similar to ag and ack";
    homepage = "https://github.com/BurntSushi/ripgrep";
    license = pkgs.lib.licenses.unlicense;
    maintainers = [ ];
  };
}