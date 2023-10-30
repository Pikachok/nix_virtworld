{ config
, lib
, buildGoModule
, fetchFromGitHub
, libpcap
}:

let
  cfg = config.services.virtwold;
in
{
  virtwold = buildGoModule rec {
    pname = "virtwold";
    version = "23.03.0";

    proxyVendor = true;

    buildInputs = [ libpcap ];

    vendorSha256 = "sha256-AubVmFptEQLqj5YUwP33VgIHvCB7c9H4fM7BzHxpQ1M=";

    preBuild = "go get github.com/google/gopacket/pcap@v1.1.19";

    src = fetchFromGitHub {
      owner = "ScottESanDiego";
      repo = "virtwold";
      rev = "${version}";
      hash = "sha256-fM51aKkqCt5DnC/IJz3iUPc/Tblx5og8wQanPkbf6PY=";
    };

    meta = with lib; {
      description = "Simple command-line snippet manager, written in Go";
      homepage = "https://github.com/ScottESanDiego/virtwold";
      license = licenses.mit;
      maintainers = with maintainers; [ kalbasit ];
      };
  };

  systemd.services.virtwold = {
      description = "libvirt wake on lan daemon";
      wantedBy = [ "multi-user.target" ];
      After = "network.target";
      Wants = "libvirtd.service";
      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
        RestartSec = "30s";
        ExecStart = ''
        /usr/local/bin/virtwold -interface %i
      '';
      };
    };
}