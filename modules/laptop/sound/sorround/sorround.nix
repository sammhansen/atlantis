{pkgs, ...}: let
  wavs = pkgs.stdenv.mkDerivation {
    name = "virtual-surround-wav";
    src = pkgs.fetchFromGitHub {
      owner = "sammhansen";
      repo = "sorround";
      rev = "5fc87479a22983be30cf14e139ef9fad4e20ce0e";
      sha256 = "1in7xq3al95nnzzlxl1i8sgagw325pfs9kv5b6781psljsnp35nj";
    };
    installPhase = ''
      mkdir -p $out/etc/pipewire/wavs
      cp -R ./wavs/atmos.wav $out/etc/pipewire/wavs/atmos.wav
    '';
  };

  atmosWav = "${wavs}/etc/pipewire/wavs/atmos.wav";
in {
  services.pipewire.extraConfig.pipewire = {
    "context.modules" = [
      {
        name = "libpipewire-module-filter-chain";
        flags = ["nofail"];
        args = {
          node.description = "Virtual Surround Sink";
          media.name = "Virtual Surround Sink";
          filter.graph = {
            nodes = [
              {
                type = "builtin";
                label = "copy";
                name = "copyFL";
              }
              {
                type = "builtin";
                label = "copy";
                name = "copyFR";
              }
              {
                type = "builtin";
                label = "copy";
                name = "copyFC";
              }
              {
                type = "builtin";
                label = "copy";
                name = "copyRL";
              }
              {
                type = "builtin";
                label = "copy";
                name = "copyRR";
              }
              {
                type = "builtin";
                label = "copy";
                name = "copySL";
              }
              {
                type = "builtin";
                label = "copy";
                name = "copySR";
              }
              {
                type = "builtin";
                label = "copy";
                name = "copyLFE";
              }

              {
                type = "builtin";
                label = "convolver";
                name = "convFL_L";
                config = {
                  filename = atmosWav;
                  channel = 0;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convFL_R";
                config = {
                  filename = atmosWav;
                  channel = 1;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convSL_L";
                config = {
                  filename = atmosWav;
                  channel = 2;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convSL_R";
                config = {
                  filename = atmosWav;
                  channel = 3;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convRL_L";
                config = {
                  filename = atmosWav;
                  channel = 4;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convRL_R";
                config = {
                  filename = atmosWav;
                  channel = 5;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convFC_L";
                config = {
                  filename = atmosWav;
                  channel = 6;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convFR_R";
                config = {
                  filename = atmosWav;
                  channel = 7;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convFR_L";
                config = {
                  filename = atmosWav;
                  channel = 8;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convSR_R";
                config = {
                  filename = atmosWav;
                  channel = 9;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convSR_L";
                config = {
                  filename = atmosWav;
                  channel = 10;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convRR_R";
                config = {
                  filename = atmosWav;
                  channel = 11;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convRR_L";
                config = {
                  filename = atmosWav;
                  channel = 12;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convFC_R";
                config = {
                  filename = atmosWav;
                  channel = 13;
                };
              }

              {
                type = "builtin";
                label = "convolver";
                name = "convLFE_L";
                config = {
                  filename = atmosWav;
                  channel = 6;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convLFE_R";
                config = {
                  filename = atmosWav;
                  channel = 13;
                };
              }

              {
                type = "builtin";
                label = "mixer";
                name = "mixL";
              }
              {
                type = "builtin";
                label = "mixer";
                name = "mixR";
              }
            ];
            links = [
              {
                output = "copyFL:Out";
                input = "convFL_L:In";
              }
              {
                output = "copyFL:Out";
                input = "convFL_R:In";
              }
              {
                output = "copySL:Out";
                input = "convSL_L:In";
              }
              {
                output = "copySL:Out";
                input = "convSL_R:In";
              }
              {
                output = "copyRL:Out";
                input = "convRL_L:In";
              }
              {
                output = "copyRL:Out";
                input = "convRL_R:In";
              }
              {
                output = "copyFC:Out";
                input = "convFC_L:In";
              }
              {
                output = "copyFR:Out";
                input = "convFR_R:In";
              }
              {
                output = "copyFR:Out";
                input = "convFR_L:In";
              }
              {
                output = "copySR:Out";
                input = "convSR_R:In";
              }
              {
                output = "copySR:Out";
                input = "convSR_L:In";
              }
              {
                output = "copyRR:Out";
                input = "convRR_R:In";
              }
              {
                output = "copyRR:Out";
                input = "convRR_L:In";
              }
              {
                output = "copyFC:Out";
                input = "convFC_R:In";
              }
              {
                output = "copyLFE:Out";
                input = "convLFE_L:In";
              }
              {
                output = "copyLFE:Out";
                input = "convLFE_R:In";
              }

              {
                output = "convFL_L:Out";
                input = "mixL:In 1";
              }
              {
                output = "convFL_R:Out";
                input = "mixR:In 1";
              }
              {
                output = "convSL_L:Out";
                input = "mixL:In 2";
              }
              {
                output = "convSL_R:Out";
                input = "mixR:In 2";
              }
              {
                output = "convRL_L:Out";
                input = "mixL:In 3";
              }
              {
                output = "convRL_R:Out";
                input = "mixR:In 3";
              }
              {
                output = "convFC_L:Out";
                input = "mixL:In 4";
              }
              {
                output = "convFC_R:Out";
                input = "mixR:In 4";
              }
              {
                output = "convFR_R:Out";
                input = "mixR:In 5";
              }
              {
                output = "convFR_L:Out";
                input = "mixL:In 5";
              }
              {
                output = "convSR_R:Out";
                input = "mixR:In 6";
              }
              {
                output = "convSR_L:Out";
                input = "mixL:In 6";
              }
              {
                output = "convRR_R:Out";
                input = "mixR:In 7";
              }
              {
                output = "convRR_L:Out";
                input = "mixL:In 7";
              }
              {
                output = "convLFE_R:Out";
                input = "mixR:In 8";
              }
              {
                output = "convLFE_L:Out";
                input = "mixL:In 8";
              }
            ];
            inputs = ["copyFL:In" "copyFR:In" "copyFC:In" "copyLFE:In" "copyRL:In" "copyRR:In" "copySL:In" "copySR:In"];
            outputs = ["mixL:Out" "mixR:Out"];
          };
          capture.props = {
            node.name = "effect_input.virtual-surround-7.1-hesuvi";
            media.class = "Audio/Sink";
            audio.channels = 8;
            audio.position = ["FL" "FR" "FC" "LFE" "RL" "RR" "SL" "SR"];
          };
          playback.props = {
            node.name = "effect_output.virtual-surround-7.1-hesuvi";
            node.passive = true;
            audio.channels = 2;
            audio.position = ["FL" "FR"];
          };
        };
      }
    ];
  };
}
