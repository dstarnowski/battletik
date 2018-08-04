:foreach function in=[/system script environment find name~"^bt[A-Z]"] do={
  /system script environment remove $function;
}
