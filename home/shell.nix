{ pkgs, ... }:

{
  pkgs.mkShell {
    packages = [
      (pkgs.python312.withPackages (python-pkgs: with python-pkgs; [
        # select Python packages here
        numpy
        pandas
      ]))
    ];
  };
}