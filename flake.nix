{
  description = "华中科技大学实习报告与笔记本的 Typix 构建环境";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur-dzming = {
      url = "github:DzmingLi/nur-packages";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      typix,
      nur-dzming,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ] (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfreePredicate =
            package:
            builtins.elem (nixpkgs.lib.getName package) [
              "windows-fonts"
              "stzhongsong"
              "chuangyi-jianxingkai"
            ];
        };
        typixLib = typix.lib.${system};
        nur = import nur-dzming { inherit pkgs; };
        fontPaths = [
          "${nur.windows-fonts}/share/fonts/truetype"
          "${nur.stzhongsong}/share/fonts/truetype"
          "${nur.chuangyi-jianxingkai}/share/fonts/truetype"
        ];
        typstPackages = [
          {
            name = "cuti";
            version = "0.4.0";
            hash = "sha256-erKkNXoH/x5WAMTg/bAB1I2AcUd4QCbtBvmHx/zk/Nc=";
          }
        ];
        documents = typixLib.mkTypstDerivation {
          name = "hust-internship-documents";
          src = pkgs.lib.fileset.toSource {
            root = ./.;
            fileset = pkgs.lib.fileset.unions [
              ./report.typ
              ./template.typ
              ./notebook.typ
              ./notebook-template.typ
              ./build.sh
              ./assets
            ];
          };
          inherit fontPaths;
          unstable_typstPackages = typstPackages;
          nativeBuildInputs = [
            pkgs.poppler-utils
            pkgs.gawk
          ];
          buildPhaseTypstCommand = ''
            export SOURCE_DATE_EPOCH=1
            bash ./build.sh
          '';
          installPhaseCommand = ''
            mkdir -p "$out"
            cp report.pdf report-cover.pdf report-inner.pdf "$out/"
            cp notebook.pdf notebook-cover.pdf notebook-inner.pdf "$out/"
          '';
        };
      in
      {
        packages.default = documents;
        checks.documents = documents;
        devShells.default = typixLib.devShell {
          inherit fontPaths;
          TYPST_PACKAGE_CACHE_PATH = typixLib.fetchTypstPackages typstPackages;
          packages = [
            pkgs.poppler-utils
            pkgs.gawk
          ];
        };
      }
    );
}
