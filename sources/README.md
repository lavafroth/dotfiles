# Compiling the Sponsorblock library for mpv

```sh
git submodule update --init --recursive
cd mpv-sponsorblock
cargo build --release --locked
cp ./target/release/libmpv_sponsorblock.so ../mpv/scripts/sponsorblock.so
```
