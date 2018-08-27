{ pkgs, lib, ... }:

let
  customization = {
    vimrcConfig = (import ./customization.nix { pkgs = pkgs; });
  } // { name = "vim"; };

  custom_vim = pkgs.vim_configurable.customize customization;

  vim = lib.overrideDerivation custom_vim (o: {
    #aclSupport              = false;
    #cscopeSupport           = true;
    #darwinSupport           = true;
    #fontsetSupport          = true;
    #ftNixSupport            = true;
    #gpmSupport              = true;
    #gui                     = true;
    #hangulinputSupport      = false;
    #luaSupport              = true;
    #multibyteSupport        = true;
    #mzschemeSupport         = false;
    #netbeansSupport         = false;
    #nlsSupport              = false;
    #perlSupport             = false;
    #pythonSupport           = true;
    #rubySupport             = false;
    #sniffSupport            = false;
    #tclSupport              = false;
    #ximSupport              = false;
    #xsmpSupport             = false;
    #xsmp_interactSupport    = false;
  });

in [
  vim
  pkgs.python
  pkgs.ctags
]
