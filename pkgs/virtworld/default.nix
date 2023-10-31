{ lib, buildGoModule, fetchFromGitHub, libpcap }:

buildGoModule rec {
    pname = "virtwold";
    version = "23.03.0";

    proxyVendor = true;

    buildInputs = [ libpcap ];

    vendorSha256 = "AubVmFptEQLqj5YUwP33VgIHvCB7c9H4fM7BzHxpQ1M=";

    preBuild = "go get github.com/google/gopacket/pcap@v1.1.19";

    src = fetchFromGitHub {
      owner = "ScottESanDiego";
      repo = "virtwold";
      rev = "${version}";
      sha256 = "fM51aKkqCt5DnC/IJz3iUPc/Tblx5og8wQanPkbf6PY=";
    };

    meta = with lib; {
      description = "Simple command-line snippet manager, written in Go";
      homepage = "https://github.com/ScottESanDiego/virtwold";
      license = licenses.mit;
      maintainers = with maintainers; [ i ];
      };
}