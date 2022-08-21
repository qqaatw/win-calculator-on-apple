# Windows Calculator on Apple

A Windows calculator ported to macOS with SwiftUI interface.

<img src="assets/standard_mode.png " alt="standard mode" width="200"/>
<img src="assets/programmer_mode.png " alt="programmer mode" width="200"/>

# Build

Clone the project:

```bash
git clone --recursive https://github.com/qqaatw/MSCalculator.git
```

Install the prerequisite via Homebrew:

```bash
brew install cmake
# if you didn't select Xcode before, select the one you want to use.
sudo xcode-select -switch /Applications/Xcode.app
```

Build:

```bash
mkdir bulid && cd build
cmake .. -G Xcode  # generate Xcode project & configure compilers
cmake --build . --target Calculator  # build
```

The executable will be located in `build/Debug/Calculator.app`

# Development

TODO list:

1. UI improvement
1. Adding scientific mode
1. Unit testing
1. CI/CD
1. iOS support