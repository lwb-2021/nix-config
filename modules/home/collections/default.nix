{ lib, my-utils, ... }:
{
  imports = my-utils.mkImportAll ./.;
}
