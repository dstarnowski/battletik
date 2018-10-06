# Main launcher for the BattleTik program

# Global funcrions required
/system script run bt-test-uninstall;
/system script run bt-test-functions;
:global btDrawTable;
:global btCoordChar;
:global btCheckNeighbors;

# Setting the initial variables
:local localTable [:toarray ""];
:for x from=1 to=10 do={
  :for y from=1 to=10 do={
    :local coords ([$btCoordChar $x] . "$y");
    :set ($localTable->$coords) 0;
  }
}
:local remoteTable [:toarray ""];
:for x from=1 to=10 do={
  :for y from=1 to=10 do={
    :local coords ([$btCoordChar $x] . "$y");
    :set ($remoteTable->$coords) 0;
  }
}

# Game beginning - setting the ships on the board
:local shipLengths {4;3;3;2;2;2;1;1;1;1};
:foreach $shipLength in=$shipLengths do={
  :local deployed -1;
  :do {
    $btDrawTable $localTable $remoteTable "Please, enter coordinates and direction (L,R,D,U) to deploy the ship, e.g. D5R" "This ship will have the length of $shipLength squares";
    :local input [$btInput];
    :local coords [:toarray ""];
    :local direction [:pick $input ([:len $input]-1)];
    :local coordStart [:pick $input 0 ([:len $input]-1)];
    :if ([:tonum "$direction"]!="$direction") do={
      :set $coordStart $input;
      :set $direction "d";
    }
    
  } while=($deployed<1)
}

$btDrawTable $localTable $remoteTable "This is the table" "Please, wait...4";
# The end - cleaning the global functions
/system script run bt-test-uninstall;
