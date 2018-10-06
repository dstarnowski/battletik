# Main launcher for the BattleTik program

# Global funcrions required
/system script run bt-test-uninstall;
/system script run bt-test-functions;
:global btDrawTable;
:global btCoordChar;
:global btCoordInt;
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
:foreach shipLength in=$shipLengths do={
  :local message "This ship will have the length of $shipLength squares";
  :local deployed 0;
  :do {
    :if ($deployed=0) do={
      $btDrawTable $localTable $remoteTable "" "Please, enter coordinates and direction (L,R,D,U) to deploy the ship, e.g. D5R" $message;
    }
    :if ($deployed=-1) do={
      $btDrawTable $localTable $remoteTable "ERROR: the ship goes out of the board!" "Please, enter coordinates and direction (L,R,D,U) to deploy the ship, e.g. D5R" $message;
    }
    :if ($deployed=-2) do={
      $btDrawTable $localTable $remoteTable "ERROR: the ship touches another ship!" "Please, enter coordinates and direction (L,R,D,U) to deploy the ship, e.g. D5R" $message;
    }
    :local input [$btInput];
    :local direction [:pick $input ([:len $input]-1)];
    :local coords [:pick $input 0 ([:len $input]-1)];
    :if ([:tonum "$direction"]!="$direction") do={
      :set $coords $input;
      :set $direction "d";
    }
    :local deployed 1;
    :local x [:pick $coords 1 [:len $coords]];
    :local y [$btCoordInt [:pick $coords 0]];
    :if (($direction="r") or ($direction="R")) do={
      :for xi from=$x to=($x+$shipLength-1) do={
        :if (($xi>10) and ($deployed=1)) do={
          :set $deployed -1;
        }
        :if (([$btCheckNeighbors $localTable ([$btCoordChar $y]."$xi")]>0) and ($deployed=1)) do={
          :set $deployed -2;
        }
      }
    }
    :if (($direction="l") or ($direction="L")) do={
      :for xi from=$x to=($x-$shipLength+1) do={
        :if (($xi<0) and ($deployed=1)) do={
          :set $deployed -1;
        }
        :if (([$btCheckNeighbors $localTable ([$btCoordChar $y]."$xi")]>0) and ($deployed=1)) do={
          :set $deployed -2;
        }
      }
    }
    :if (($direction="d") or ($direction="D")) do={
      :for yi from=$y to=($y+$shipLength-1) do={
        :if (($yi>10) and ($deployed=1)) do={
          :set $deployed -1;
        }
        :if (([$btCheckNeighbors $localTable ([$btCoordChar $yi]."$x")]>0) and ($deployed=1)) do={
          :set $deployed -2;
        }
      }
    }
    :if (($direction="u") or ($direction="U")) do={
      :for yi from=$y to=($y-$shipLength+1) do={
        :if (($yi<0) and ($deployed=1)) do={
          :set $deployed -1;
        }
        :if (([$btCheckNeighbors $localTable ([$btCoordChar $yi]."$x")]>0) and ($deployed=1)) do={
          :set $deployed -2;
        }
      }
    }
    :if ($deployed=1) do={
      :if (($direction="r") or ($direction="R")) do={
        :for xi from=$x to=($x+$shipLength-1) do={
          :local xapply $xi;
          :local yapply [$btCoordChar $y];
          :local apply ("$yapply"."$xapply");
          :set ($localTable->$apply) 1;
        }
      }
    }
  } while=($deployed<1)
}

$btDrawTable $localTable $remoteTable "This is the table" "Please, wait...4";
# The end - cleaning the global functions
/system script run bt-test-uninstall;
