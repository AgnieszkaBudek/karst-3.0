{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = with pkgs; [gfortran clang gnumake mumps];
    shellHook = ''
        export MUMPS_DIR=${pkgs.mumps}/opt/mumps
    '';
}
