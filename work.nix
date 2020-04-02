{ pkgs, ... }: 
{
  pullImage {
    imageName = "cadro/timedoctor2"; 
    imageDigest = "sha256:a82f0d424e9cb266f01a984d91d0d41fbc0036d153e48c5d02dbfcf041146e1a"; 
    finalImageName = "timedoctor2"; 
    finalImageTag = "latest";  
    sha256 = "a82f0d424e9cb266f01a984d91d0d41fbc0036d153e48c5d02dbfcf041146e1a"; 
  }

  systemd.user.services.timedoctor2 = {
    script = ''
       docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix cadro/timedoctor2 /opt/timedoctor2/timedoctor2
    '';
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
  };
}
