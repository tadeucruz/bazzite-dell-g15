# bazzite-dell-g15

> ⚠️ **Work in Progress** — Use at your own risk.

A personal custom [Bazzite](https://bazzite.gg) image for my Dell G15 laptop. This is not affiliated with the Bazzite project or Universal Blue in any way — it's just a personal setup I use on my own machine.

## What's included

- **acpi_call** — kernel module compiled from source for fan/temperature control
- **AWCC** (Alienware Command Center for Linux) — fan and thermal management GUI

## Dependencies / upstream projects

- [ublue-os/bazzite](https://github.com/ublue-os/bazzite) — base image (`bazzite-nvidia-open:stable`)
- [ublue-os/image-template](https://github.com/ublue-os/image-template) — template this repo is based on
- [nix-community/acpi_call](https://github.com/nix-community/acpi_call) — acpi_call kernel module source
- [tr1xem/AWCC](https://github.com/tr1xem/AWCC) — Alienware Command Center for Linux

## Switching to this image

If you're already running a bootc-based system (Bazzite, Bluefin, etc.):

```bash
sudo bootc switch ghcr.io/tadeucruz/bazzite-dell-g15:latest
sudo reboot
```

## Disclaimer

This image is provided as-is, with no guarantees. I take no responsibility for any issues it may cause on your system. This project has no affiliation with Bazzite, Universal Blue, or Dell.
