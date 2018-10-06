#Functions imported by BattleTik program

# btInput - allowing user interaction, waiting for "value: " to be entered, returning it as result
:global btInput do={
  :return;
}

# btUpper - function changing lowercase coordinates to uppercase, e.g. [$btUpper "d4"] = "D4"
:global btUpper do={
  :local rest [:pick $1 0];
  :local last [:pick $1 1 [:len $1]];
  :if ($rest="a") do={:set $rest "A";}
  :if ($rest="b") do={:set $rest "B";}
  :if ($rest="c") do={:set $rest "C";}
  :if ($rest="d") do={:set $rest "D";}
  :if ($rest="e") do={:set $rest "E";}
  :if ($rest="f") do={:set $rest "F";}
  :if ($rest="g") do={:set $rest "G";}
  :if ($rest="h") do={:set $rest "H";}
  :if ($rest="i") do={:set $rest "I";}
  :if ($rest="j") do={:set $rest "J";}
  :return ($rest . $last);
}

# btCoordInt - function returning the number of row described by letter, e.g. [$btCoordInt "C"] = 3
:global btCoordInt do={
  :local response 0;
  :if ($1="A") do={:set $response 1;}
  :if ($1="B") do={:set $response 2;}
  :if ($1="C") do={:set $response 3;}
  :if ($1="D") do={:set $response 4;}
  :if ($1="E") do={:set $response 5;}
  :if ($1="F") do={:set $response 6;}
  :if ($1="G") do={:set $response 7;}
  :if ($1="H") do={:set $response 8;}
  :if ($1="I") do={:set $response 9;}
  :if ($1="J") do={:set $response 10;}
  :if ($response=0) do={:error message="Provided a wrong letter! Only letters A-J uppercase"}
  :return $response;
}

# btCoordChar - function translating the number of row to the letter, e.g. [$btCoordChar 8] = "H"
:global btCoordChar do={
  :local response 0;
  :if ($1="1") do={:set $response "A";}
  :if ($1="2") do={:set $response "B";}
  :if ($1="3") do={:set $response "C";}
  :if ($1="4") do={:set $response "D";}
  :if ($1="5") do={:set $response "E";}
  :if ($1="6") do={:set $response "F";}
  :if ($1="7") do={:set $response "G";}
  :if ($1="8") do={:set $response "H";}
  :if ($1="9") do={:set $response "I";}
  :if ($1="10") do={:set $response "J";}
  :if ($response=0) do={:error message="Provided a wrong number! Only numbers between 1 and 10!"}
  :return $response;
}

# btDrawTable - initial function drawing the table of battleships, $1 - own, $2 - enemy
:global btDrawTable do={
  :global btCoordChar;
  :put "                  YOU                              ENEMY";
  :put "     1  2  3  4  5  6  7  8  9  10     1  2  3  4  5  6  7  8  9  10";
  :put "    +--+--+--+--+--+--+--+--+--+--+   +--+--+--+--+--+--+--+--+--+--+";
  :for x from=1 to=10 do={
    :local line ("  ".[$btCoordChar $x]." |");
    :for y from=1 to=10 do={
      :local coords ([$btCoordChar $x]."$y");
      :local value ($1->$coords);
      :if ($value="0") do={:set $line ($line . "  |")};
      :if ($value="1") do={:set $line ($line . "[]|")};
      :if ($value="2") do={:set $line ($line . "::|")};
      :if ($value="3") do={:set $line ($line . "##|")};
    }
    :set $line ($line." ".[$btCoordChar $x]." |");
    :for y from=1 to=10 do={
      :local coords ([$btCoordChar $x]."$y");
      :local value ($2->$coords);
      :if ($value="0") do={:set $line ($line . "  |")};
      :if ($value="1") do={:set $line ($line . "[]|")};
      :if ($value="2") do={:set $line ($line . "::|")};
      :if ($value="3") do={:set $line ($line . "##|")};
    }
    :put "$line";
    :put "    +--+--+--+--+--+--+--+--+--+--+   +--+--+--+--+--+--+--+--+--+--+";
  }
}
