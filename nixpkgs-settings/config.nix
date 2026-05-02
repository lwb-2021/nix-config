{ lib, ... }:
{
  allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "p7zip"
      "unrar"

      #####
      "nvidia-x11"
      "nvidia-settings"

      "cuda-merged"
      "cuda_cuobjdump"
      "cuda_gdb"
      "cuda_nvcc"
      "cuda_nvdisasm"
      "cuda_nvprune"
      "cuda_cccl"
      "cuda_cudart"
      "cuda_cupti"
      "cuda_cuxxfilt"
      "cuda_nvml_dev"
      "cuda_nvrtc"
      "cuda_nvtx"
      "cuda_profiler_api"
      "cuda_sanitizer_api"

      "libcublas"
      "libcufft"
      "libcurand"
      "libcusolver"
      "libcusparse"

      "libnvjitlink"

      "libnpp"

      # For PyTorch
      "triton"
      "torch"
      "cudnn"
      "libcusparse_lt"
      "libcufile"

      ##### SO NVIDIA FUCK YOU

      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
      "xone-dongle-firmware"

      "zerotierone"

      "ttf-wps-fonts"

      "pantum-driver"

      "obsidian"

      "tampermonkey"

      "vscode"
      "vscode-extension-ms-python-vscode-pylance"
      "vscode-extension-mhutchie-git-graph"
      "vscode-extension-github-copilot"
      "vscode-extension-ms-vscode-remote-remote-ssh"

      "idea"

      "drawio"

      "evafast"

      "windows-fonts"

      "010editor"
      "burpsuite"
    ];
  permittedInsecurePackages = [
  ];
  cudaSupport = true;
  packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

}
