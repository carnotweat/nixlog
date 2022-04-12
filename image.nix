containerImage = pkgs.dockerTools.buildLayeredImage
  {
    name = "sdf.org/~sameers";
    contents = [ pkgs.python3 htmlPages ];
    config = {
      Cmd = [
        "${pkgs.python3}/bin/python" "-m" "http.server" 8000
        "--directory" "${htmlPages}"
      ];
      ExposedPorts = {
        "8000/tcp" = { };
      };
    };
  };
