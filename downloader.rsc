:local url "https://raw.githubusercontent.com/startik/battletik/devel/scripts";
:local files {"functions"};
:foreach file in=$files do={
  /tool fetch mode=https url="$url/battletik-$file.rsc"
}
